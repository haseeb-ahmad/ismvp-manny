class UsersController < ApplicationController
	require 'twilio-ruby'

	before_action :get_user
	before_filter :is_twillio_verified
	
	def yodlee_data
		@user_financial_data = current_user.identities.where(provider: 'yodlee').take.all_data
		@user_financial_data = JSON.parse(@user_financial_data) if @user_financial_data.class.to_s == "String"
	end
	
	def fetch_yodlee_data
		require 'httparty'

		cobrand_login = User::YODLEE_COB_LOGIN
		cobrand_password = User::YODLEE_COB_PASSWORD
		username = params[:user][:username]
		user_pwd = params[:user][:password]
		@isSmoothSession = true
		cobSession = ''
		userSession = ''
		data = Hash.new

		#here made first call to cobrand authentication, first step of authentication of API
		cobSession = User.getCobSession
		@isSmoothSession = false  unless (cobSession.present? && cobSession.length > 0)

		if @isSmoothSession
			# post call for user session, second step for authentication of API
			data["user"] = User.getUserSession(username, user_pwd, cobSession)
			userSession =  data["user"]["session"]["userSession"] rescue ''
		end
		@isSmoothSession = false  unless (userSession.present? && userSession.length > 0)

		if @isSmoothSession
			#make call for user accounts information
			data["account"] = User.getAccount(cobSession, userSession)
		end

		if @isSmoothSession
			#make call for user transactions information
			data["statements"] = User.getStatements(cobSession, userSession)
		end

		if @isSmoothSession
			#make call for user transactions information
			data["documents"] = User.getDocuments(cobSession, userSession)
		end

		if @isSmoothSession
			#make call for user transactions information
			data["holdings"] = User.getHoldings(cobSession, userSession)
		end

		if @isSmoothSession
			#make call for user transactions information
			data["transactions"] = User.getTransactions(cobSession, userSession)
		end

		#here make new identity for yodlee
		if @isSmoothSession
			identity = current_user.identities.where(provider: 'yodlee').take
			identity = current_user.identities.new(uid: data["user"]["id"], provider: 'yodlee' ) unless identity.present?
			identity.all_data = data.to_hash.to_json
			identity.save
		end
	end

	def dashboard
		@identities = current_user.identities
		render 'connections'
	end

	def browser_knows
	end

	def edit
		super
	end

	def browser_knows_list	
	end
	
	def connections
		@identities = current_user.identities
	# 	# require 'linkedin-scraper'
	# 	# profile = Linkedin::Profile.new( "https://www.linkedin.com/in/jeffweiner08/" ) 
	# 	# puts profile.inspect
	end

	def account
		
	end

	def disconnect
		identity = Identity.get_identity(current_user.id, params[:identity])
		identity.delete
		flash[:alert] = I18n.t("connections.disconnect_network", :identity => identity.provider.capitalize)
		redirect_to user_connections_path(:user_id => current_user.id)
	end

	def update_contacts
		# Update User Contacts (user press update button)
		Delayed::Job.enqueue UpdateContacts.new(current_user.id), :queue => "queue_#{current_user.id}"
		redirect_to user_contacts_path
	end

	private
		def get_user
			@user = current_user
		end

		def is_twillio_verified
			if  current_user.present?
				if current_user.is_twillio_verified == false && current_user.twillio_verification_code.present?
					redirect_to new_twillio_confirmation_path()
				end
			end
		end
		# def is_twillio
		# 	if  current_user.present?
		# 		if current_user.twillio_verification_code.nil?
		# 			flash[:success] = "Update Your moile number!"
		# 			redirect_to edit_user_registration_path(user_id: current_user.id)
		# 		end
		# 	end
		# end
end
