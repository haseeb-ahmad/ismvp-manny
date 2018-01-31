class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise 	:database_authenticatable, :registerable, :omniauthable,
			:recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :identities, :dependent => :destroy
	has_many :contacts, :dependent => :destroy

	attr_accessible :email, :password, :password_confirmation, :remember_me,
				  	:first_name, :last_name

	scope :get_user, lambda {|email| where(:email => email)}
	
	def self.find_or_create(auth)
		# If user exists then update else create new user
		user = User.where("email = '#{auth.info.email}'").first_or_initialize
		user.email		= auth.info.email
		user.first_name	= auth.info.first_name
		user.last_name	= auth.info.last_name
		user.password = Devise.friendly_token

		# No need to send confirmation email to user
		user.skip_confirmation!
		user.save!(:validate => false)

		user
	end

	def get_google_plus_contacts(identity)
		circles, access_token = GpService.get_gp_circles(identity.token, identity.refresh_token, identity.expires_at < Time.now.utc)
		identity.update(:token => access_token) unless access_token.nil?
		gmail_contacts = GpService.get_gmail_contacts(identity.token, identity.refresh_token)
		contacts = Array.new
		
		circles.each do |circle|
			next unless circle.display_name

			name = circle.display_name.downcase
			contact = self.contacts.find_contact(name, circle.id).first_or_initialize
			circle = GpService.get_gp_people(identity.token, identity.refresh_token, circle.id)
			gmail_contact = gmail_contacts.select{|con| con.name != nil && con.name.downcase == circle.display_name.downcase}.first

			contact.google_id 		= circle.id
			contact.full_name 		||= circle.display_name.downcase
			contact.email 			= gmail_contact.email if gmail_contact
			contact.given_name 		||= circle.name.givenName.downcase
			contact.gender 			||= circle.gender.downcase if circle.gender
			contact.network_url		||= circle.url if circle.url
			contact.photo_url		||= circle.image.url if circle.image and circle.image.url

			contact.save!
			identity.contacts << contact
				
			contacts << contact
		end
		contacts
	end

	def get_facebook_contacts(identity)
		friends = FbService.get_fb_friends(identity.token)
		contacts = Array.new

		friends.each do |friend|
			contact = self.contacts.find_contact(friend.name.downcase ,friend.identifier).first_or_initialize
			friend = friend.fetch

			work = facebook_companies_data(friend)
			education = facebook_education_data(friend)

			contact.facebook_id 		= friend.identifier
			contact.full_name 			= friend.name.downcase
			contact.first_name 			= friend.first_name.downcase
			contact.last_name			= friend.last_name.downcase
			contact.network_url			= friend.link
			contact.network_username	= friend.username if friend.username
			contact.email				||= "#{friend.username}@facebook.com" if friend.username
			contact.gender				= friend.gender.downcase  if friend.gender
			contact.hometown			= friend.hometown.name if friend.hometown
			contact.photo_url			= friend.picture
			contact.work				= work if work
			contact.education 			= education if education

			contact.save!
			identity.contacts << contact
			
			contacts << contact
		end
		contacts
	end

	def facebook_companies_data(friend)
		companies = ""
		friend.work.each do |company|
			name = company.employer.name if company.employer
			location = company.location.name if company.location
			position = company.position.name if company.position
			start_date = company.start_date if company.start_date
			end_date = company.end_date if company.end_date

			companies = companies + "#{name} - #{location} - #{position} - #{start_date}-#{end_date} \n"
		end
		companies.empty? ? nil : companies
	end

	def facebook_education_data(friend)
		education = ""
		friend.education.each do |edu|
			school = edu.school.name if edu.school
			description = edu.classes.first.name if edu.classes.count > 0
			period = edu.year.name if edu.year
			education = education + "#{school} - #{description} - #{period} \n"
		end
		education.empty? ? nil : education
	end

	def get_linkedin_contacts(identity)
		connections = LinService.get_lin_connections(identity.token, identity.secret)
		contacts = Array.new

		connections.each do |connection|
			name = connection.first_name.downcase + " " + connection.last_name.downcase
			contact = self.contacts.find_contact(name, connection.id).first_or_initialize
			public_info = LinService.get_connection_information(connection.public_profile_url)

			education = linkedin_education_data(public_info)
			work = linkedin_companies_data(public_info)

			contact.linkedin_id 	||= connection.id
			contact.full_name		||= name
			contact.first_name		||= connection.first_name.downcase
			contact.last_name		||= connection.last_name.downcase
			contact.network_url		= connection.site_standard_profile_request.url if connection.site_standard_profile_request
			contact.job_title		= connection.headline if connection.headline
			contact.industry		= connection.industry if connection.industry
			contact.country			= connection.location.name if connection.location
			contact.photo_url		||= connection.picture_url
			contact.education 		= education if education
			contact.work 			= work if work

			contact.save!
			identity.contacts << contact

			contacts << contact
		end
		contacts
	end

	def linkedin_education_data(public_info)
		education = ""
		public_info.education.each do |edu|
			education = education + "#{edu[:name]} - #{edu[:description]} - #{edu[:period]} \n"
		end
		education.empty? ? nil : education
	end

	def linkedin_companies_data(public_info)
		current_companies = ""
		public_info.current_companies.each do |company|
			current_companies = current_companies + "#{company[:company]} - #{company[:address]} - #{company[:title]} - #{company[:description]} - #{company[:start_date]}-#{company[:end_date]} \n"
		end

		past_companies = ""
		public_info.past_companies.each do |company|
			past_companies = past_companies + "#{company[:company]} - #{company[:address]} - #{company[:title]} - #{company[:description]} - #{company[:start_date]}-#{company[:end_date]} \n"
		end
		
		companies = current_companies + past_companies
		companies.empty? ? nil : companies
	end

	def password_required?
		super if confirmed?
	end

	def password_match?
		self.errors[:password] << "can't be blank" if password.blank?
		self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
		self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
		password == password_confirmation && !password.blank?
	end

	def only_if_unconfirmed
		pending_any_confirmation {yield}
	end
end
