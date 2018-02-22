class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :configure_devise_params, if: :devise_controller?
	layout :dynamic_layout

	def after_sign_up_path_for(resource)
		after_sign_in_path_for(resource)
	end

	def after_sign_in_path_for(resource)
		if resource.phone_number.present?
			ConfirmationSender.send_confirmation_to(resource)
	      	new_twillio_confirmation_path(user_id: resource.id)
		else
			dashboard_users_path()
		end
	end

	# Control which layout is used.
	def dynamic_layout
		if current_user.nil?
			"sign_up"
		else
			"application"
		end
	end

	protected

	def configure_devise_params
		# Need email only for sign up...
		devise_parameter_sanitizer.for(:sign_up) do |u|
			u.permit(:email, :password, :password_confirmation, :remember_me)
		end
	end
end