require 'linkedin'
module LinService
	def self.get_lin_connections(token, secret)
		client = LinkedIn::Client.new
		client.authorize_from_access(token, secret)
		connections = client.connections(:fields => %w(public-profile-url id first_name last_name headline location industry num-connections summary specialties positions picture-url site_standard_profile_request))
		connections[:all]
	end

	def self.get_connection_information(public_profile_url)
		profile = Linkedin::Profile.get_profile(public_profile_url)
	end
end