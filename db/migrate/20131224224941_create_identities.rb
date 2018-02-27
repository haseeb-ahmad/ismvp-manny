class CreateIdentities < ActiveRecord::Migration
	def change

		create_table :identities do |t|
			t.integer :user_id
			t.string :provider
			t.string :uid
			t.text :token
			t.text :secret
			t.text :refresh_token
			t.datetime :expires_at
			
			t.timestamps
		end
		
		add_index :identities, :user_id
		add_index :identities, :provider
		add_index :identities, :uid
	end
end
