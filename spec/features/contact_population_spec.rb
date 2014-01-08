require 'spec_helper'

feature "Contacts Population" do

	before do		
		@user = FactoryGirl.build(:user)
		@user.skip_confirmation!
		@user.save!

		@contacts = Array.new
		25.times do
			contact = FactoryGirl.create(:contact)
			@user.contacts << contact
			@contacts << contact
		end
		sign_in
	end

	def sign_in
		visit new_user_registration_path
		expect(page).to have_text("Stay in touch, stay on top.")
		click_link("LOGIN")

		fill_in "user_email", :with => @user.email
		fill_in "user_password", :with => @user.password
		click_button("Sign in")
	end

	def inspect_contact(contact, index)
		find("//a[@href='#contact_#{index + 1}']").click
		within ("//div[@id='contact_#{index + 1}']") do
			page.should have_text(contact.full_name.upcase)
			page.should have_text(contact.email)
			page.should have_text(contact.notes.last)

			page.should have_link("Edit Contact")
			page.should have_link("Add note")
			page.should have_link("Show all notes")
		end
	end

	scenario "population of contacts on main page" do
		visit user_contacts_path(:user_id => @user.id)

		@contacts.each_with_index do |contact, index|
			inspect_contact(contact, index)
		end
	end
end