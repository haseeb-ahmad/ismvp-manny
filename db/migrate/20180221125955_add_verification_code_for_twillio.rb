class AddVerificationCodeForTwillio < ActiveRecord::Migration
  def change
  	add_column :users, :twillio_verification_code, :integer
  end
end
