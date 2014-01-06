# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'factory_girl'
require 'capybara/rails'
require 'capybara/rspec'
require "email_spec"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Rails.application.routes.default_url_options[:host] = 'test.host'
# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
	# ## Mock Framework
	#
	# If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
	#
	# config.mock_with :mocha
	# config.mock_with :flexmock
	# config.mock_with :rr

	# Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
	config.fixture_path = "#{::Rails.root}/spec/fixtures"

	config.include Devise::TestHelpers, :type => :controller

	# If you're not using ActiveRecord, or you'd prefer not to run each of your
	# examples within a transaction, remove the following line or assign false
	# instead of true.
	config.use_transactional_fixtures = true

	# If true, the base class of anonymous controllers will be inferred
	# automatically. This will be the default behavior in future versions of
	# rspec-rails.
	config.infer_base_class_for_anonymous_controllers = false

	# Run specs in random order to surface order dependencies. If you find an
	# order dependency and want to debug it, you can fix the order by providing
	# the seed, which is printed after each run.
	#		 --seed 1234
	config.order = "random"
end


OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({:provider => 'facebook', :uid => '1234567',
	:credentials => OmniAuth::AuthHash.new({:token => 'facebook_token', :expires_at => 1382340450}),
	:info => OmniAuth::AuthHash.new({:email => 'test@facebook.com'}) })

OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({:provider => 'linkedin', :uid => '1234568',
	:credentials => OmniAuth::AuthHash.new({:token => 'linkedin_token'}),
	:info => OmniAuth::AuthHash.new({:email => 'test@linkedin.com'}) })

OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({:provider => 'google', :uid => '1234569',
	:credentials => OmniAuth::AuthHash.new({:token => 'google_token'}),
	:info => OmniAuth::AuthHash.new({:email => 'test@google.com'}) })