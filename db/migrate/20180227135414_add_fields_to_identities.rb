class AddFieldsToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :all_data, :jsonb
    add_column :identities, :email, :string
  end
end
