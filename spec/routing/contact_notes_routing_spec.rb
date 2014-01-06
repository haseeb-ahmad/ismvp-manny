require "spec_helper"

describe ContactNotesController do
	describe "routing" do

		it "routes to #index" do
			get("/users/1/contacts/1/contact_notes").should route_to("contact_notes#index", :user_id => "1", :contact_id => "1")
		end

		it "routes to #new" do
			get("/users/1/contacts/1/contact_notes/new").should route_to("contact_notes#new", :user_id => "1", :contact_id => "1")
		end

		it "routes to #show" do
			get("/users/1/contacts/1/contact_notes/1").should route_to("contact_notes#show", :id => "1", :user_id => "1", :contact_id => "1")
		end

		it "routes to #edit" do
			get("/users/1/contacts/1/contact_notes/1/edit").should route_to("contact_notes#edit", :id => "1", :user_id => "1", :contact_id => "1")
		end

		it "routes to #create" do
			post("/users/1/contacts/1/contact_notes").should route_to("contact_notes#create", :user_id => "1", :contact_id => "1")
		end

		it "routes to #update" do
			put("/users/1/contacts/1/contact_notes/1").should route_to("contact_notes#update", :id => "1", :user_id => "1", :contact_id => "1")
		end

		it "routes to #destroy" do
			delete("/users/1/contacts/1/contact_notes/1").should route_to("contact_notes#destroy", :id => "1", :user_id => "1", :contact_id => "1")
		end

	end
end
