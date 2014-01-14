require 'spec_helper'

feature "Import Contacts" do

	def sign_in(user)
		visit new_user_registration_path
		expect(page).to have_text("Stay in touch, stay on top.")
		click_link("LOGIN")

		fill_in "user_email", :with => user.email
		fill_in "user_password", :with => user.password
		click_button("Sign in")
	end

	def facebook_identity
		identity = FactoryGirl.build(:identity)
		identity.provider =	"facebook"
		identity.uid = "100006772657323"
		identity.token = "CAAGvaKzr9EQBAO1Dxo1LRXf7G0piZAdJw0vIQ5ZApeZAN5pgfTpnV4OscSU1Re1Rx8PVuTpfSAt682uVp1Wm0jWOIP9ypjL2tpm0is4aQmPRvSHEubZCUuYM8JnDAwRYD56VMpMZAZCvS3SXwxusfgbaxCZCnLpVwBw4qAbyrzfp90HXfP0ZBYhA9tOg1wNUehEZD"
		identity.secret = nil
		identity.refresh_token = nil
		identity.expires_at = "2014-03-07 10:33:43"
		identity
	end

	def google_identity
		identity = FactoryGirl.build(:identity)
		identity.provider =	"google"
		identity.uid = "109623195054811643689"
		identity.token = "ya29.1.AADtN_WlW7HzUI3xhaq593H2NNAoZ6j72ecoZL4BZ0scbAumuQlmwVBdo6-XVyExZhF4zA"
		identity.secret = nil
		identity.refresh_token = "1/2vpWniMGuhH9Hh0yXxpi67564CfMpbquHO_lG5Qh3E8"
		identity.expires_at = "2014-01-06 12:26:45"
		identity
	end

	def linkedin_identity
		identity = FactoryGirl.build(:identity)
		identity.provider =	"linkedin"
		identity.uid = "t-WeXBTEPT"
		identity.token = "ff351ecd-ab9b-471c-99db-9141eecc8edf"
		identity.secret = "089910fe-e572-4caa-95ca-3ce7fc8d6707"
		identity.refresh_token = nil
		identity.expires_at = nil
		identity
	end


	scenario "importing from facebook" do
		user = FactoryGirl.build(:user)
		user.skip_confirmation!
		user.save!

		identity = facebook_identity
		user.identities << identity

		fb_contacts = user.get_facebook_contacts(identity)
		fb_contacts.should == user.contacts
	end

	scenario "importing from google" do
		user = FactoryGirl.build(:user)
		user.skip_confirmation!
		user.save!

		identity = google_identity
		user.identities << identity

		gp_contacts = user.get_google_plus_contacts(identity)
		gp_contacts.should == user.contacts
	end

	scenario "importing from linkedin" do
		user = FactoryGirl.build(:user)
		user.skip_confirmation!
		user.save!

		identity = linkedin_identity
		user.identities << identity

		link_contacts = user.get_linkedin_contacts(identity)
		link_contacts.should == user.contacts
	end
end