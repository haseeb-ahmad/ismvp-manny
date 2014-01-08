class Contact < ActiveRecord::Base
	before_save :default_values

	belongs_to :user
	belongs_to :identity
	has_many :notes, :dependent => :destroy

	validates :full_name, presence: true

	attr_accessible	:full_name, :first_name, :last_name, :family_name, :given_name, :photo_url, :gender,
		:network_url, :network_username, :job_title, :industry, :country, :email, :phone, :user_id,
		:identity_id, :organization, :country, :about, :notes

	scope :get_person_contact, lambda { |name| where(:full_name => name)}
	
	scope :get_active_contacts, lambda { |user_id| where("user_id = ? AND is_deleted = ?", user_id, false) }
	scope :get_deleted_contacts, lambda { |user_id| where("user_id = ? AND is_deleted = ?", user_id, true) }

	def default_values
		self.photo_url = "/assets/photo.png" if (self.photo_url.nil? || self.photo_url.empty?)
	end

	def form_social_network?
		self.google_id || self.linkedin_id || self.facebook_id
	end
end
