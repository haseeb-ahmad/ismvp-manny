class Identity < ActiveRecord::Base
	
	belongs_to :user

	validates :provider, presence: true
	validates :uid, presence: true, uniqueness: {scope: :provider}

	attr_accessible :email, :expires_at, :provider, :refresh_token, :secret, :token, :uid, :user_id

	def self.find_or_create(auth, user)

		identity = user.identities.find { |identity| identity.provider == auth.provider }

		if identity.nil?
			identity 				= Identity.new
			identity.user_id		= user.id
			identity.provider		= auth.provider
			identity.uid			= auth.uid
			identity.token			= auth.credentials.token
			identity.secret			= auth.credentials.secret
			identity.expires_at		= Time.at(auth.credentials.expires_at) if auth.provider == "facebook"
			identity.refresh_token	= auth.credentials.refresh_token

			identity.save!
			user.identities << identity
		end
		identity
	end
end