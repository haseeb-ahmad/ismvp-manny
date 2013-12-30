require 'google/api_client'
module GpService
	def self.get_gp_circles(access_token, refresh_token)
		client = Google::APIClient.new
		client.authorization.client_id = GOOGLE_CONFIG[:app_id]
		client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
		client.authorization.access_token = access_token
		plus = client.discovered_api('plus')
		circles = client.execute(:api_method => plus.people.list, :parameters => {'collection' => 'visible', 'userId' => 'me'}).data.items
		circles
	end

	def self.get_gp_people(access_token, refresh_token, uid)
		client = Google::APIClient.new
		client.authorization.client_id = GOOGLE_CONFIG[:app_id]
		client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
		client.authorization.access_token = access_token
		plus = client.discovered_api('plus')
		person = client.execute(:api_method => plus.people.get, :parameters => {'userId' => uid}).data
		person
	end

end