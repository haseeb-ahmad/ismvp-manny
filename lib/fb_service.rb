module FbService
	def self.get_fb_contacts(token)
		friends = fb_friends_from(token)		
		contacts = Array.new

		friends.each do |friend|
			
			friend = friend.fetch
			contact = Contact.new

			contact.name = friend.name
			contact.first_name = friend.first_name
			contact.last_name = friend.last_name
			contact.network = "facebook"
			contact.network_page = friend.link
			contact.network_id = friend.identifier
			contact.network_username = friend.username
			contact.gender = friend.gender
			#contact.posts = friend.posts
			contact.photo = friend.picture

			contacts << contact
		end
		contacts
	end

	private

	def self.fb_user_from(token)
		FbGraph::User.me(token)
	end

	def self.fb_friends_from(token)
		return fb_user_from(token).friends(options = {:access_token => token}) || []
	end

	def self.people_from_fb_friends(fb_friends)
		friends_identifiers =	fb_friends.empty? ? [] : fb_friends.collect(&:identifier)
		Person.joins(:users).where('users.uid' => friends_identifiers, 'users.provider' => 'facebook')
	end

	def self.get_my_friends(token)
		friends_list = fb_friends_from(token)
		people_from_fb_friends(friends_list).authorized.order('people.name')
	end

	def self.search_fb_friends(token, search_term)
		search_term.empty? ? [] : get_my_friends(token).
															where("UPPER(people.name) LIKE UPPER(?)", "%#{search_term}%")
	end

	def self.post_on_my_wall(token, msg, link = '', options = {})
		fb_user = fb_user_from(token)

		if options[:append_name]
			fb_user = fb_user.fetch
			msg = "#{fb_user.name} #{msg}"
		end

		fb_user.feed!(:message => msg, :link => link)
	end


	def self.fb_logout_url(fb_api_key, fb_session_key, return_url)
		"http://www.facebook.com/logout.php" << 
		"?api_key=#{fb_api_key}" << 
		"&session_key=#{fb_session_key}" << 
		"&confirm=1&next=#{return_url}"
	end
end
