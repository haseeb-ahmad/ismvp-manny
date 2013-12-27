class UsersController < ApplicationController
	before_filter :authenticate_user!

	def index
		@user = current_user
		@identities = current_user.identities
	end

	def contact
		@user = current_user
		@identities = current_user.identities
		@friends = @user.get_friends
	end

	def disconnect
		identity = Identity.where("user_id = '#{current_user.id}' AND provider = '#{params[:identity]}'").first
		identity.delete
		flash.now[:alert] = "You are disconnected from #{identity.provider.capitalize}."
		redirect_to users_index_path
	end

end
