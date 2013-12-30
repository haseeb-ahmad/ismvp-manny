require 'google/api_client'
module GpService
	def self.get_gp_contacts(token)
		client = create_client_object(token)
		plus = client.discovered_api('plus')
		circles = get_circles(client, plus)
		contacts = Array.new

		circles.each do |circle|
			contact = Contact.new
			circle = get_people(client, plus, circle.id)

			contact.name = circle.display_name
			contact.family_name = circle.name.familyName
			contact.given_name = circle.name.givenName
			contact.gender = circle.gender
			contact.network_id = circle.id
			contact.network = "google+"
			contact.network_page = circle.url
			contact.photo = circle.image.url

			contacts << contact
		end
		contacts
	end

	private

	def self.create_client_object(token)
		client = Google::APIClient.new
		client.authorization.client_id = GOOGLE_CONFIG[:app_id]
		client.authorization.client_secret = GOOGLE_CONFIG[:app_secret]
		client.authorization.access_token = token
		client
	end

	def self.get_circles(client, plus)
		circles = client.execute(:api_method => plus.people.list, :parameters => {'collection' => 'visible', 'userId' => 'me'}).data.items
		circles
	end

	def self.get_people(client, plus, uid)
		client.execute(:api_method => plus.people.get, :parameters => {'userId' => uid}).data
	end

end