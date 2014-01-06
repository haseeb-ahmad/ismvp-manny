FactoryGirl.define do
	factory :contact_note do
		note 	{ Faker::Lorem.characters }
	end
end