class RegistrationsController < Devise::RegistrationsController
	
	def create
        # Ckeck if user exists
		user = User.where("email = '#{sign_up_params[:email]}'").first
		
		if user
            # If user is present without password then send emial for confirmation
			if user.encrypted_password.blank?
				user.confirmed_at = ""
                user.save!

				user.send_confirmation_instructions
			end
			redirect_to root_path
		else
			super
		end
	end
end