class Contact < ActiveRecord::Base
	before_save :default_values

	belongs_to :user
	belongs_to :identity
	has_many :notes, :dependent => :destroy

	validates :full_name, presence: true

	attr_accessible	:full_name, :first_name, :last_name, :family_name, :given_name, :photo_url, :gender,
		:network_url, :network_username, :job_title, :industry, :country, :email, :phone, :user_id,
		:identity_id, :organization, :country, :about, :notes, :education, :work

	scope :get_active_contacts, lambda { where(:is_deleted => false) }
	scope :get_deleted_contacts, lambda { where(:is_deleted => true) }
	
	def default_values
		self.photo_url = "/assets/photo.png" if (self.photo_url.nil? || self.photo_url.empty?)
		self.education = self.education.gsub("\r", "") if self.education
		self.work = self.work.gsub("\r", "") if self.work
	end

	def self.find_contact(name, network_id)
		where("full_name = ? OR google_id = ? OR facebook_id = ? OR linkedin_id = ?",name,network_id,network_id,network_id)		
	end

	def form_social_network?
		self.google_id || self.linkedin_id || self.facebook_id
	end
end
