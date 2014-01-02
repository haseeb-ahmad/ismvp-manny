class Contact < ActiveRecord::Base
	before_save :default_values

	belongs_to :user
	belongs_to :identity
	has_many :contact_notes, :dependent => :destroy

	validates :full_name, presence: true

	attr_accessible	:full_name, :first_name, :last_name, :family_name, :given_name, :photo_url, :gender,
		:network_url, :network_username, :job_title, :industry, :country, :email, :phone, :user_id,
		:identity_id, :organization, :country, :about, :notes

	scope :get_person_contact, lambda { |name| where(:full_name => name)}

	def default_values
		self.photo_url = "/assets/photo.png" if self.photo_url.nil?
	end
end
