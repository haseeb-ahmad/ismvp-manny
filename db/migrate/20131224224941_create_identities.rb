class CreateIdentities < ActiveRecord::Migration
	def change

		create_table :identities do |t|
			t.integer :user_id
			t.string :provider
			t.string :uid
			t.string :token
			t.string :secret
			t.string :refresh_token
			t.datetime :expires_at
			
			t.timestamps
		end
		
		add_index :identities, :user_id
		add_index :identities, :provider
		add_index :identities, :uid
	end
end
