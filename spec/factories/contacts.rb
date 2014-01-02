FactoryGirl.define do
	factory :contact do
		full_name			{ Faker::Name.name }
		first_name			{ Faker::Name.first_name }
		last_name			{ Faker::Name.last_name }
		given_name			{ Faker::Name.first_name }
		photo_url			{ Faker::Internet.url }
		gender				{ ["male", "female"].sample }
		email				{ Faker::Internet.email }
		phone				{ Faker::PhoneNumber.phone_number }
		user 				nil
		identity			nil
		network_url			{ Faker::Internet.url }
		network_username	{ Faker::Name.name }
		job_title			{ Faker::Commerce.department }
		organization		{ Faker::Company.name }
		industry			{ Faker::Company.name }
		country				{ Faker::Address.country }
		about				{ Faker::Lorem.characters }
		notes				{ Faker::Lorem.characters }
	end
end

	