require 'spec_helper'

feature "Connect through Social Networks" do

	before do
		@user = FactoryGirl.create(:user)
		@user.skip_confirmation!

		Capybara.current_driver = :selenium
	end

	def sign_in
		visit new_user_session_path
		fill_in "user_email", :with => @user.email
		fill_in "user_password", :with => @user.password		
		click_button 'Sign in'
		
	end

	def connect (networks)
		networks.each do |network|
			click_link "connet_#{network}"
			sleep 2
		end
	end

	def disconnect(networks)
		networks.each do |network|
			click_link "connet_#{network}"
			sleep 2
		end
	end

	def is_connected?(network)
		begin
				page.find("btn_connet_to_#{network}").visible?
		rescue Exception => e
				false
		end
	end

	def confirm_identities(user, identities_count)
		expect(page).to have_text("Email: #{user.email}")
		expect(page).to have_text("Number of Conected Identities: #{identities_count}")
	end

	scenario "Connect and Disconnect with Multiple Networks" do
		#sign_in
		
		#confirm_identities(@user, 0)
		#debugger
		#connect(["facebook", "google", "linkedin"])


	end
end