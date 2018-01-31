class AddhashColumnInIdentity < ActiveRecord::Migration
  def change
  	add_column :identities, :all_data, :jsonb
  end
end
