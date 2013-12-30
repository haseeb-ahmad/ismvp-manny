require 'linkedin'
module LinService
	def self.get_lin_contacts(token, secret)
		connections = get_connections(token, secret)
		contacts = Array.new
		connections.each do |connection|
			contact = Contact.new

			contact.first_name = connection.first_name
			contact.last_name = connection.last_name
			contact.network = "linkedin"
			contact.network_id = connection.id
			contact.network_page = connection.site_standard_profile_request.url
			contact.job = connection.headline
			contact.industry = connection.industry
			contact.country = connection.location.name
			contact.photo = connection.picture_url

			contacts << contact
		end
		contacts
	end

	private

	def self.get_connections(token, secret)
		client = LinkedIn::Client.new
		client.authorize_from_access(token, secret)
		connections = client.connections
		connections[:all]
	end
end