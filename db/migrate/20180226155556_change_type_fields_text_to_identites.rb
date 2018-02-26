class ChangeTypeFieldsTextToIdentites < ActiveRecord::Migration
  def change
    def up
      change_column :identities, :token, :text
      change_column :identities, :refresh_token, :text
      change_column :identities, :secret, :text
    end

    def down
      change_column :identities, :token, :string
      change_column :identities, :refresh_token, :string
      change_column :identities, :secret, :string
    end
  end
end
