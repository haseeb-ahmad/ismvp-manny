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

		# No need to send confirmation email to user
		user.skip_confirmation!
		user.save!(:validate => false)

		user
	end

	def get_contacts
		identity = Identity.get_identity(self.id, "google")
		gp_contacts = identity.nil? ? [] : get_google_plus_contacts(identity)

		identity = Identity.get_identity(self.id, "facebook")
		fb_contacts = identity.nil? ? [] : get_facebook_contacts(identity)

		identity = Identity.get_identity(self.id, "linkedin")
		lin_contacts = identity.nil? ? [] : get_linkedin_contacts(identity)

		self.contacts
	end

	def get_google_plus_contacts(identity)
		circles, access_token = GpService.get_gp_circles(identity.token, identity.refresh_token, identity.expires_at < Time.now.utc)
		identity.update(:token => access_token) unless access_token.nil?
		gmail_contacts = GpService.get_gmail_contacts(identity.token, identity.refresh_token)
		contacts = Array.new
		
		circles.each do |circle|
			circle = GpService.get_gp_people(identity.token, identity.refresh_token, circle.id)

			if circle.display_name
				contact = self.contacts.get_person_contact(circle.display_name.downcase).first_or_initialize

				if contact.given_name.nil? || contact.given_name.empty?

					contact.full_name ||= circle.display_name.downcase

					gmail_contact= gmail_contacts.select{|con| con.name !=nil && con.name.downcase == circle.display_name.downcase}.first
					contact.email ||= gmail_contact.email if gmail_contact
					contact.given_name ||= circle.name.givenName.downcase
					contact.gender ||= circle.gender.downcase if circle.gender
					contact.network_url ||= circle.url if circle.url
					contact.photo_url ||= circle.image.url if circle.image and circle.image.url

					contact.save!
					identity.contacts << contact
				end
				contacts << contact
			end
		end
		contacts
	end

	def get_facebook_contacts(identity)
		friends = FbService.get_fb_friends(identity.token)
		contacts = Array.new

		friends.each do |friend|
			contact = self.contacts.get_person_contact(friend.name.downcase).first_or_initialize
			if contact.gender.nil? || contact.network_username.nil?
				friend = friend.fetch

				contact.full_name ||= friend.name.downcase
				contact.first_name ||= friend.first_name.downcase
				contact.last_name ||= friend.last_name.downcase
				contact.network_url ||= friend.link
				contact.network_username ||= friend.username
				contact.gender ||= friend.gender.downcase  unless friend.gender.nil?
				contact.hometown ||= friend.hometown.name rescue nil
			#	unless friend.birthday.empty?
			#		contact.birthday ||= friend.birthday.to_date
			#	end
				contact.photo_url ||= friend.picture

				contact.save!
				identity.contacts << contact
			end
			contacts << contact
		end
		contacts
	end

	def get_linkedin_contacts(identity)
		connections = LinService.get_lin_connections(identity.token, identity.secret)
		contacts = Array.new
		connections.each do |connection|
			contact = self.contacts.get_person_contact(connection.first_name.downcase + " " + connection.last_name.downcase).first_or_initialize
			
			if contact.job_title.nil? || contact.industry.nil?

				contact.full_name ||= connection.first_name.downcase + " " + connection.last_name.downcase
				contact.first_name ||= connection.first_name.downcase
				contact.last_name ||= connection.last_name.downcase
				contact.network_url ||= connection.site_standard_profile_request.url
				contact.job_title ||= connection.headline
				contact.industry ||= connection.industry
				contact.country ||= connection.location.name
				contact.photo_url ||= connection.picture_url

				contact.save!
				identity.contacts << contact				
			end
			contacts << contact
		end
		contacts
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
