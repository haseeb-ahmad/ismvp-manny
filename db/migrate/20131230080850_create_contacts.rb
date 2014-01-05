class CreateContacts < ActiveRecord::Migration
	def change
		create_table :contacts do |t|
			t.string :full_name, :default => nil
			t.string :first_name, :default => nil
			t.string :last_name, :default => nil
			t.string :given_name, :default => nil
			
			t.string :photo_url, :default => nil
			t.string :network_url, :default => nil
			t.string :network_username, :default => nil
			
			t.string :gender, :default => nil
			t.string :email, :default => nil
			t.string :phone, :default => nil
			t.date	 :birthday, :default => nil
			t.string :hometown, :default => nil
			
			t.string :job_title, :default => nil
			t.string :organization, :default => nil
			t.string :industry, :default => nil
			t.string :country, :default => nil

			t.string :about, :default => nil
			t.integer :notes_id

			t.references :user, index: true
			t.references :identity, index: true

			t.timestamps
		end
	end
end
