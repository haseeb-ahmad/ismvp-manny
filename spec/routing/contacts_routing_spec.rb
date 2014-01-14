require "spec_helper"

describe ContactsController do
	describe "routing" do

		it "routes to #index" do
			get("/users/1/contacts").should route_to("contacts#index", :user_id => "1")
		end

		it "routes to #new" do
			get("/users/1/contacts/new").should route_to("contacts#new", :user_id => "1")
		end

		it "routes to #show" do
			get("/users/1/contacts/1").should route_to("contacts#show", :id => "1", :user_id => "1")
		end

		it "routes to #edit" do
			get("/users/1/contacts/1/edit").should route_to("contacts#edit", :id => "1", :user_id => "1")
		end

		it "routes to #create" do
			post("/users/1/contacts").should route_to("contacts#create", :user_id => "1")
		end

		it "routes to #update" do
			put("/users/1/contacts/1").should route_to("contacts#update", :id => "1", :user_id => "1")
		end

		it "routes to #destroy" do
			delete("/users/1/contacts/1").should route_to("contacts#destroy", :id => "1", :user_id => "1")
		end

	end
end
