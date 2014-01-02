require 'spec_helper'

feature "Signing In" do

	before do
		@user = FactoryGirl.build(:user)
		@user.skip_confirmation!
	end

	def create_user
		@user.save!
	end

	def sign_in
		visit new_user_registration_path
		expect(page).to have_text("Stay in touch, stay on top.")
		click_link("LOGIN")

		fill_in "user_email", :with => @user.email
		fill_in "user_password", :with => @user.password
		click_button("Sign in")
	end

	def confirm_signed_in
		begin
			expect(page).to have_text("Signed in successfully.")
			true
		rescue Exception => e
			false
		end
	end

	scenario "User already Created" do
		create_user
		sign_in
		confirm_signed_in.should == true
	end

	scenario "User does not Exists" do
		sign_in
		confirm_signed_in.should == false
		expect(page).to have_text("Invalid email or password.")
	end
end