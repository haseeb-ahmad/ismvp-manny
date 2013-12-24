class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def callback
		auth = request.env["omniauth.auth"]
		user = User.find_or_create(auth)
		identity = Identity.find_or_create(auth, user)

		sign_in_and_redirect user
	end

  alias_method :facebook,	:callback
  alias_method :linkedin,	:callback
  alias_method :google,		:callback

end
