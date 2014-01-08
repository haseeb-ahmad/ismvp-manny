class UpdateContacts < Struct.new(:user_id)

	def perform
		user = User.find(user_id)

		identity = Identity.get_identity(user.id, "google")
		gp_contacts = identity.nil? ? [] : user.get_google_plus_contacts(identity)

		identity = Identity.get_identity(user.id, "facebook")
		fb_contacts = identity.nil? ? [] : user.get_facebook_contacts(identity)

		identity = Identity.get_identity(user.id, "linkedin")
		lin_contacts = identity.nil? ? [] : user.get_linkedin_contacts(identity)
	end
end