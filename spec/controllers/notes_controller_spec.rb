require 'spec_helper'

describe NotesController do
let(:note_attributes) { FactoryGirl.attributes_for(:note) }
	before :each do
		request.env['devise.mapping'] = Devise.mappings[:user]
		@user = FactoryGirl.create(:user, :confirmation_token => nil, :confirmation_sent_at => nil, :confirmed_at => Time.now.utc)
		@contact = FactoryGirl.create(:contact, :user_id => @user.id)
		sign_in @user
	end

	describe "Note Controller" do
		it "create a new note" do
			expect { post :create, {:note => note_attributes, :user_id => @user.id, :contact_id => @contact.id} }.to change(Note, :count).by(1)
			assigns(:note).should be_a(Note)
			assigns(:note).should be_persisted
		end
	end

end
