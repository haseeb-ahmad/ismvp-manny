class AddLimittoIdentitiesColumns < ActiveRecord::Migration
  def change
  	def up
      change_column :identities, :token, :text, :limit => nil
      change_column :identities, :refresh_token, :text, :limit => nil
      change_column :identities, :secret, :text, :limit => nil
      change_column :identities, :uid, :text, :limit => nil
    end

    def down
      change_column :identities, :token, :string
      change_column :identities, :refresh_token, :string
      change_column :identities, :secret, :string
      change_column :identities, :uid, :string
    end
  end
end
