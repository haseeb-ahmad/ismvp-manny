require 'google/api_client'
module GpService
	def self.get_gp_circles(access_token, refresh_token, get_new_access_token)
		new_access_token = get_new_access_token ? renew_access_token(access_token, refresh_token) : nil
		access_token = new_access_token unless new_access_token.nil?

		client = Google::APIClient.new(:application_name => "Contact", :application_version => "1.0")
		client.authorization.client_id = GOOGLE_CONFIG[:app_id]
		client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
		client.authorization.access_token = access_token
		plus = client.discovered_api('plus')
		circles = client.execute(:api_method => plus.people.list, :parameters => {'collection' => 'visible', 'userId' => 'me'}).data.items
		[circles, new_access_token]
	end

	def self.get_gp_people(access_token, refresh_token, uid)
		client = Google::APIClient.new(:application_name => "Contact", :application_version => "1.0")
		client.authorization.client_id = GOOGLE_CONFIG[:app_id]
		client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
		client.authorization.access_token = access_token
		plus = client.discovered_api('plus')
		person = client.execute(:api_method => plus.people.get, :parameters => {'userId' => uid}).data
		person
	end

	def self.get_gmail_contacts(access_token, refresh_token)
		contacts = GmailContacts::Google.new(access_token).contacts
		contacts
	end

	private
		def self.renew_access_token(access_token, refresh_token)
			client = Google::APIClient.new(:application_name => "Contact", :application_version => "1.0")
			client.authorization.client_id = GOOGLE_CONFIG[:app_id]
			client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
			client.authorization.refresh_token = refresh_token
			client.authorization.fetch_access_token!
			client.authorization.access_token
		end

end