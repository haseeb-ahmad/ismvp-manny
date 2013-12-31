require 'spec_helper'

feature "Signing In" do

	before do
		@user = FactoryGirl.build(:user)
		@user.skip_confirmation!
	end

	def sign_in
		debugger
		visit new_user_session_path
		#expect(page).to have_text("Stay in touch, stay on top.")
		#click_link("LOGIN")

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

	scenario "User already created" do
		debugger
		@user.save!
		sign_in
		confirm_signed_in.should == true
	end

	scenario "User does not exists" do
		#sign_in
		#debugger
		#confirm_signed_in.should == false
	end
end