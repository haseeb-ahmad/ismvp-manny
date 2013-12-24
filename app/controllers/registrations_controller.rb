class RegistrationsController < Devise::RegistrationsController
	
    def create
        user = User.where("email = '#{sign_up_params[:email]}'").first
        
        if user
            if user.encrypted_password.blank?
        	   user.send_confirmation_instructions
            end
            redirect_to root_path
        else
            super
        end
	end
end