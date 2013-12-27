require 'linkedin'
module LinService
	def self.get_lin_friends(token, secret)
		friends = get_friends(token, secret)
		friends
	end

	private

	def self.get_friends(token, secret)
		client = LinkedIn::Client.new
		client.authorize_from_access(token, secret)
		connections = parse_client_connections(client.connections)
		connections
	end

	def self.parse_client_connections(connections)
		
		connections
	end
end