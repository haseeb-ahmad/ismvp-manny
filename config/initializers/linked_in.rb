LinkedIn.configure do |config|
	config.token = LINKEDIN_CONFIG[:app_id]
	config.secret = LINKEDIN_CONFIG[:app_secret]
end