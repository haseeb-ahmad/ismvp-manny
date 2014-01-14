require 'spec_helper'

describe ContactsController do

	let(:contact_attributes) { FactoryGirl.attributes_for(:contact) }
	before :each do
		request.env['devise.mapping'] = Devise.mappings[:user]
		@user = FactoryGirl.create(:user, :confirmation_token => nil, :confirmation_sent_at => nil, :confirmed_at => Time.now.utc)
		@contact = FactoryGirl.create(:contact, :user_id => @user.id)
		sign_in @user
	end

	describe "Contact Controller" do
		it "create a new contact" do
			expect { post :create, {:contact => contact_attributes, :user_id => @user.id} }.to change(Contact, :count).by(1)
			assigns(:contact).should be_a(Contact)
			assigns(:contact).should be_persisted
		end

		it "edit contact" do
			get :edit, {:id => @contact.id, :user_id => @user.id}
			assigns(:contact).should eq(@contact)
		end

		it "update contact" do
			put :update, {:id => @contact.id, :user_id => @user.id, :contact => { "first_name" => "tibi est dicas" }}
			assigns(:contact).first_name.should == "tibi est dicas"
		end

		it "delete contact" do
			expect { delete :destroy, {:id => @contact.id, :user_id => @user.id}}.to change(Contact, :count).by(0)
			assigns(:contact).should be_persisted
			@contact.reload
			@contact.is_deleted.should == true
			@user.contacts.get_deleted_contacts.last.should == @contact
		end
	end
	

end
