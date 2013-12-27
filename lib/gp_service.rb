require 'google/api_client'
module GpService
	def self.get_gp_friends(token)

		client = Google::APIClient.new(:application_name => 'My Aapplication', :application_version => '1.0.0')
		
		# client.authorization.client_id = GOOGLE_CONFIG[:app_id]
    	# client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
		client.authorization.access_token = token

		plus = client.discovered_api('plus', 'v1')

		result = client.execute( plus.activities.list, :collection => 'public', :userId => 'me').data
		#result.data

	end

end