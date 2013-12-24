class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise 	:database_authenticatable, :registerable, :omniauthable,
			:recoverable, :rememberable, :trackable, :validatable, :confirmable

	has_many :identities, :dependent => :destroy

	attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name

    def self.find_or_create(auth)

    	user = User.where("email = '#{auth.info.email}'").first_or_initialize

    	unless user.persisted?
			user.email		= auth.info.email
			user.first_name	= auth.info.first_name
			user.last_name	= auth.info.last_name

			user.skip_confirmation!

			user.save!(:validate => false)
    	end
    	user
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
