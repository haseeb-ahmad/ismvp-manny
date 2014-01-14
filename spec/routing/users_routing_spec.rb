require "spec_helper"

describe UsersController do
	describe "routing" do

		it "routes to #connections" do
			get("/users/1/connections").should route_to("users#connections", :user_id => "1")
		end

		it "routes to #disconnect" do
			get("/users/disconnect").should route_to("users#disconnect")
		end
	end
end
