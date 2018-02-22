class UsersController < ApplicationController
	require 'twilio-ruby'

	before_filter :authenticate_user!
	before_action :get_user
	before_filter :is_twillio_verified,except: [:edit]

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
					redirect_to new_twillio_confirmation_path(user_id: current_user.id)
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
