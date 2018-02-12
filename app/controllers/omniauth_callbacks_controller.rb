class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def callback
		require 'koala'
		auth = request.env["omniauth.auth"]
		@graph = Koala::Facebook::API.new(auth["credentials"]["token"])

		if auth.provider == "facebook"
			#getting all family list
			auth["extra"]["raw_info"]["family"] = @graph.get_connection("me", "family", { limit:5000, fields: ["id", "name", "relationship", "picture"]})
			#getting all friends list
			auth["extra"]["raw_info"]["friendlists"] = @graph.get_connection("me", "taggable_friends", limit: 5000)
			# friends that use this app
			auth["extra"]["raw_info"]["friends"] = @graph.get_connection("me", "friends", { limit:5000, fields: ["id", "name", "picture"]})
			#groups info joined by user
			auth["extra"]["raw_info"]["groups"] = @graph.get_connection("me", "groups", limit: 5000)
			#pages name with date liked by user
			auth["extra"]["raw_info"]["likes"] =  @graph.get_connection("me", "likes", limit: 5000)
			#user all uploaded photos, or photos in which user is tagged
			auth["extra"]["raw_info"]["photos"] = @graph.get_connection("me", "photos", {fields:["name","picture"], limit:5000})
			#all user events
			auth["extra"]["raw_info"]["events"] = @graph.get_connection("me", "events", limit: 5000)
			#all videos uploaded or tagged in users
			auth["extra"]["raw_info"]["videos"] = @graph.get_connection("me", "videos", {fields:[], limit:5000})
			#all posts shared or in tagged
			auth["extra"]["raw_info"]["posts"] = @graph.get_connection("me", "posts", {fields:["story","message","created_time","picture"], limit:5000})
		end

		user = nil
		unless current_user
			user = Identity.find_by_email(auth.info.email)&.user
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
