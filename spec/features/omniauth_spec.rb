require 'spec_helper'

feature "Connect Through Social Networks" do

	def connect (provider)
		click_link("Sign in with #{provider.capitalize}")
	end

	def confirm_user_and_identities(provider)
		user = User.get_user("test@#{provider}.com").first
		user.should_not == nil
		identity = Identity.get_identity(user.id, provider)
		identity.should_not == nil
	end

	scenario "Login/Sign Up Through Facebook" do
		visit new_user_session_path
		connect("facebook")
		confirm_user_and_identities("facebook")
		#expect(page).to have_text("You are connected to Facebook. Welcome!")
	end

	scenario "Login/Sign Up Through Google" do
		visit new_user_session_path
		connect("google")
		confirm_user_and_identities("google")
		#expect(page).to have_text("You are connected to Google. Welcome!")
	end

	scenario "Login/Sign Up Through LinkedIn" do
		visit new_user_session_path
		connect("linkedin")
		confirm_user_and_identities("linkedin")
		#expect(page).to have_text("You are connected to Linkedin. Welcome!")
	end
end