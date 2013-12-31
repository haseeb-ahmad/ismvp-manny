FactoryGirl.define do
	factory :contact do
		full_name			"MyString"
		first_name			"MyString"
		last_name			"MyString"
		given_name			"MyString"
		photo_url			"MyString"
		gender				"MyString"
		email				"MyString"
		phone				"MyString"
		user 				nil
		identity			nil
		network_url			"MyString"
		network_username	"MyString"
		job_title			"MyString"
		organization		"MyString"
		industry			"MyString"
		country				"MyString"
		about				"MyString"
		notes				"MyString"
	end
end

	