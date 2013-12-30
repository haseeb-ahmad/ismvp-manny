class Contact < ActiveRecord::Base
	belongs_to :user
	belongs_to :identity

	scope :get_person_contact, lambda { |name| where(:full_name => name)}
end
