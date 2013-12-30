require 'linkedin'
module LinService
	def self.get_lin_connections(token, secret)
		client = LinkedIn::Client.new
		client.authorize_from_access(token, secret)
		connections = client.connections
		connections[:all]
	end
end