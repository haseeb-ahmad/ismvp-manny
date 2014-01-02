require 'spec_helper'

feature "Signing Up" do

	before do
		@user = FactoryGirl.build(:user)
	end

	def signup
		visit new_user_registration_path
		expect(page).to have_text("Stay in touch, stay on top.")

		fill_in "user_email", :with => @user.email
		page.find('.signup').click
	end

	def confirm_page(user)
		visit "#{user_confirmation_path}?confirmation_token=#{user.confirmation_token}"
	end

	def set_password(user)
		expect(page).to have_text("Password")
		expect(page).to have_text("Password confirmation")

		fill_in "Password", :with => @user.password
		fill_in "Password confirmation", :with => @user.password
		click_button "Update"
	end

	scenario "Through Confirmation Email" do
		signup
		user = User.where("email = '#{@user.email}'").first
		user.encrypted_password.empty?.should == true
		
		confirm_page(user)
		set_password(@user)
		
		user = User.where("email = '#{@user.email}'").first
		user.encrypted_password.empty?.should == false
	end

	scenario "Trying Without Email" do
		@user.email = ""
		signup
		expect(page).to have_text("Please enter email to get registered.")
	end

end