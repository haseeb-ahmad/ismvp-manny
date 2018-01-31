class Addinfohash < ActiveRecord::Migration
  def change
  	add_column :identities, :info_hash, :json
  end
end
