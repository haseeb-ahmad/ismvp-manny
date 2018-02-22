class AddNumberVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_verified_number, :boolean, default: true
  end
end
