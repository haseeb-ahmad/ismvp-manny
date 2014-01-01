class RegistrationsController < Devise::RegistrationsController
	
	def create
		# Ckeck if user exists
		email = sign_up_params[:email]
		if email.empty?
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
				# New User, add user to database
				# send confirmation email.
				super
			end
		end
	end

	# Sign Up through email only.
	def sign_up_params
		params.require(:user).permit(:email)
	end
end