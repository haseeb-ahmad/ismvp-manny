FactoryGirl.define do
	factory :note do
		note 	{ Faker::Lorem.characters }
	end
end