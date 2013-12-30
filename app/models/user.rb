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
		gp_access_token, gp_refresh_token = self.identities.where(:provider=>"google").pluck(:token, :refresh_token).first
		gp_contacts = (gp_access_token.nil? || gp_refresh_token.nil?) ? [] : get_google_plus_contacts(gp_access_token, gp_refresh_token)

		fb_token = self.identities.where(:provider=>"facebook").first.token rescue nil
		fb_contacts = fb_token.nil? ? [] : get_fb_contacts(fb_token)

		lin_token, lin_secret = self.identities.where(:provider=>"linkedin").pluck(:token, :secret).first
		lin_contacts = (lin_token.nil? || lin_secret.nil?) ? [] : get_lin_contacts(lin_token, lin_secret)

		#fb_contacts + lin_contacts + gp_contacts
		self.contacts
	end

	def get_lin_contacts(token, secret)
		connections = LinService.get_lin_connections(token, secret)
		identity = self.identities.where("provider = 'linkedin'").first
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

	def get_fb_contacts(token)
		friends = FbService.get_fb_friends(token)
		identity = self.identities.where("provider = 'facebook'").first
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
				contact.gender ||= friend.gender.downcase
				contact.photo_url ||= friend.picture

				contact.save!
				identity.contacts << contact
			end
			contacts << contact
		end
		contacts
	end

	def get_google_plus_contacts(access_token, refresh_token)
		circles = GpService.get_gp_circles(access_token, refresh_token)
		identity = self.identities.where("provider = 'google'").first
		contacts = Array.new
		
		circles.each do |circle|
			contact = self.contacts.get_person_contact(circle.display_name.downcase).first_or_initialize
			
			if contact.given_name.nil?
				circle = GpService.get_gp_people(access_token, refresh_token, circle.id)

				contact.full_name ||= circle.display_name.downcase
				contact.given_name ||= circle.name.givenName.downcase
				contact.gender ||= circle.gender.downcase
				contact.network_url ||= circle.url
				contact.photo_url ||= circle.image.url

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
