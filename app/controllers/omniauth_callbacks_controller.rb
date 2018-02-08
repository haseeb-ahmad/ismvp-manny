class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def callback

		auth = request.env["omniauth.auth"]
		user = nil
		unless current_user
			user = Identity.find_by_email(auth.info.email).user
			user = User.find_or_create(auth) unless user
		else
			user = current_user
		end
		identity = Identity.find_or_create(auth, user)

		if current_user.nil?
			# User tries to Sign In / Register through some social network

  			if user.encrypted_password.empty?
  				
				# User need to set password first.
				user.confirmed_at = nil
				user.confirmation_token = Devise.friendly_token
				user.confirmation_sent_at = Time.now.utc
				user.save!(:validate => false)

				# Update User Contacts (User just signed up)
				# Delayed::Job.enqueue UpdateContacts.new(user.id), :queue => "queue_#{user.id}"

				flash[:notice] = I18n.t("sign_up.with_network", :identity => identity.provider.capitalize)
				redirect_to user_confirmation_path(:confirmation_token => user.confirmation_token)
			else
				# User is already registered. Now trying to login through social network
				sign_in_and_redirect user
			end
		else
			# User already signed in and tries to connect with some identity
			# flash[:notice] = I18n.t("connections.connect_network", :identity => identity.provider.capitalize)

			# Update User Contacts (user connects himself with some identity)
			# Delayed::Job.enqueue UpdateContacts.new(current_user.id) , :queue => "queue_#{current_user.id}"
			redirect_to user_connections_path(:user_id => current_user.id)
		end
	end

	alias_method :facebook,	:callback
	alias_method :linkedin,	:callback
	alias_method :google,	:callback

end
