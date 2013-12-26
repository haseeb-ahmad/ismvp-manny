class RegistrationsController < Devise::RegistrationsController
	
	def create
        # Ckeck if user exists
		user = User.where("email = '#{sign_up_params[:email]}'").first
		
		if user
			if user.encrypted_password.blank?
				# If user is present without password then send another emial for confirmation.
				user.confirmed_at = ""
                user.save!
				user.send_confirmation_instructions

				flash.now[:notice] = "Please check your email for account confirmation."
				redirect_to new_user_registration_path
			else
				# User exists and have valid password, he needs to sign in to continue.
				flash.now[:notice] = "#{user.email} is already registered. Please sign in to continue."
				redirect_to new_user_session
			end
		else
			# New User, add user to database and send confirmation email.
			flash.now[:notice] = "Welcome! Please check your email for account confirmation."
			super
		end
	end
end