require 'spec_helper'

describe RegistrationsController do
	before :each do
		request.env['devise.mapping'] = Devise.mappings[:user]
		@user_attributes = FactoryGirl.attributes_for(:user)
	end
	
	describe "User Registrations" do
		it "create a new user, valid params" do
			expect { post :create, {:user => @user_attributes} }.to change(User, :count).by(1)
			assigns(:user).should be_persisted
			flash.notice.should eq(I18n.t("devise.registrations.signed_up_but_unconfirmed"))
			response.should redirect_to(root_path)
		end

		it "should not create user, invalid params" do
			post :create, {:user => {:email => ""}}
			flash.alert.should eq(I18n.t("sign_up.email_param_blank"))
			response.should redirect_to(root_path)
		end
	end
end