class UsersController < ApplicationController

	def index
		if current_user
			@user = current_user
			@identities = current_user.identities
		else
			# Have no password. Take it to sign up page
			redirect_to root_path
		end
	end

	def edit
	end

	def disconnect
		identity = Identity.where("user_id = '#{current_user.id}' AND provider = '#{params[:identity]}'").first
		identity.delete
		redirect_to users_index_path
	end

end
