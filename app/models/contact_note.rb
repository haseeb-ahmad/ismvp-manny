class ContactNote < ActiveRecord::Base
	belongs_to :contact

	attr_accessible :note, :contact_id
end
