class AddTwillioVerifiedInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_twillio_verified, :boolean
  end
end
