class Identity < ActiveRecord::Base
	
	belongs_to :user
	has_many :contacts

	validates :provider, presence: true
	validates :uid, presence: true, uniqueness: {scope: :provider}

	attr_accessible :email, :expires_at, :provider, :refresh_token, :secret, :token, :uid, :user_id

	def self.get_identity(user_id, provider)
		Identity.where("user_id = ? AND provider = ?" , user_id, provider).first
	end

	def self.find_or_create(auth, user)

		identity = where(auth.slice(:provider, :uid)).first_or_initialize

		identity.user_id		= user.id
		identity.provider		= auth.provider
		identity.uid			= auth.uid
		identity.token			= auth.credentials.token
		identity.secret			= auth.credentials.secret
		identity.expires_at		= Time.at(auth.credentials.expires_at) if auth.credentials.expires_at
		identity.refresh_token	||= auth.credentials.refresh_token
		identity.all_data  = auth.to_hash.to_json
		identity.email = auth.info.email

		identity.save!
		user.identities << identity

		identity
	end
end