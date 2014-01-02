class UsersController < ApplicationController
	before_filter :authenticate_user!
	before_action :get_user

	def index
		@identities = current_user.identities
	end

	def contact
		@contacts = current_user.get_contacts
	end

	def disconnect
		identity = Identity.get_identity(current_user.id, params[:identity])
		identity.delete
		flash[:alert] = "You are disconnected from #{identity.provider.capitalize}. Friends information will not be fetched from this network in future."
		redirect_to user_index_path(:user_id => current_user.id)
	end

	private
		def get_user
			@user = current_user
		end
end
