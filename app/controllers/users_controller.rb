class UsersController < ApplicationController

	def index
		if current_user
			# Signed In User
			@user = current_user
			@identities = current_user.identities
		else
			# User needs to sign up / sign in to continue
			redirect_to new_user_registration_path
		end
	end

	def contact
		if current_user
			# Signed In User
			@user = current_user
			@identities = current_user.identities
			@friends = @user.get_friends

		else
			# User needs to sign up / sign in to continue
			redirect_to new_user_registration_path
		end
	end

	def disconnect
		identity = Identity.where("user_id = '#{current_user.id}' AND provider = '#{params[:identity]}'").first
		identity.delete

		flash.now[:alert] = "You are disconnected from #{identity.provider.capitalize}."
		redirect_to users_index_path
	end

end
