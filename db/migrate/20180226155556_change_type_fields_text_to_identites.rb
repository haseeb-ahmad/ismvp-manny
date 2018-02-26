class ChangeTypeFieldsTextToIdentites < ActiveRecord::Migration
  def change
    def up
      change_column :identities, :token, :text
      change_column :identities, :refresh_token, :text
      change_column :identities, :secret, :text
      change_column :identities, :uid, :text
    end

    def down
      change_column :identities, :token, :string
      change_column :identities, :refresh_token, :string
      change_column :identities, :secret, :string
      change_column :identities, :uid, :string
    end
  end
end
