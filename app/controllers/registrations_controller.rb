class RegistrationsController < Devise::RegistrationsController
	
	def update
	  @user = current_user
	  # if params[:user][:password].blank?
	  # 	@user.first_name = params[:user][:first_name]
	  # 	@user.last_name = params[:user][:last_name]
	  # 	send_confirmation = false

	  # 	if (@user.email != params[:user][:email])
	  # 		send_confirmation = true
	  # 		@user.unconfirmed_email = params[:user][:email]
		 #  	@user.confirmation_token = Devise.friendly_token
		 #  	@user.confirmation_sent_at = Time.now.utc
	  # 	end
	  # 	@user.save
	  # 	@user.send_confirmation_instructions if send_confirmation
	  # 	flash[:notice] = "Profile updated successfully!"
	  #   redirect_to :back
	  # else
	  # 	@user.send(:update_with_password, params[:user])
	  # 	flash[:notice] = "Profile updated successfully!"
	  #   redirect_to :back
	  # end
	  method = if params[:user][:password].blank?
	             :update_without_password
	           else
	             :update_with_password
	           end

	  if @user.send(method, params[:user])
	    flash[:notice] = "Profile updated successfully!"
	    redirect_to :back
	  else
	    render :edit
	  end
	end

	def create
		# Ckeck if user exists
		email = sign_up_params[:email]
		if email.nil? || email.empty?
			# Email filed is empty
			flash[:alert] = I18n.t("sign_up.email_param_blank")
			redirect_to root_path
		else
			user = User.get_user(email).first
			if user
				if user.encrypted_password.blank?
					# If user is present without password
					# then send another emial for confirmation.

					user.confirmed_at = nil
					user.save!
					user.send_confirmation_instructions

					flash[:notice] = I18n.t("devise.registrations.signed_up_but_unconfirmed")
					redirect_to new_user_registration_path
				else
					# User exists and have valid password,
					# he needs to sign in to continue.
					flash[:notice] = I18n.t("sign_up.already_registered", :email => user.email)
					redirect_to new_user_session_path
				end
			else
				# build_resource
				# resource.email = params[:user][:email]   #******** here resource is user 
				# resource.confirmation_token = Devise.friendly_token
				# resource.confirmation_sent_at = Time.now.utc

				# if resource.save!(:validate => false)
				#   if resource.active_for_authentication?
				#     set_flash_message :notice, :signed_up if is_navigational_format?
				#     sign_in(resource_name, resource)
				#     respond_with resource, :location => after_sign_up_path_for(resource)
				#   else
				#     set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
				#     expire_session_data_after_sign_in!
				#     respond_with resource, :location => after_inactive_sign_up_path_for(resource)
				#   end
				# else
				#   clean_up_passwords resource
				#   respond_with resource
				# end

				# if signup using just email
				# New User, add user to database
				# send confirmation email.
				super
			end
		end
	end
	# Sign Up through email only.
	def sign_up_params
		params.require(:user).permit(:email, :phone_number)
	end
end