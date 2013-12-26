class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :configure_devise_params, if: :devise_controller?
	

	def after_sign_up_path_for(resource)
		after_sign_in_path_for(resource)
	end

	def after_sign_in_path_for(resource)
		users_contact_path
	end

	protected

	def configure_devise_params
		devise_parameter_sanitizer.for(:sign_up) do |u|
			u.permit(:email, :password, :password_confirmation, :remember_me)
		end
	end

end