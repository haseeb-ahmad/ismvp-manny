class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :given_name
      t.string :photo_url
      t.string :gender
      t.string :email
      t.string :phone
      t.references :user, index: true
      t.references :identity, index: true
      t.string :network_url
      t.string :network_username
      t.string :job_title
      t.string :organization
      t.string :industry
      t.string :country
      t.string :about
      t.string :notes

      t.timestamps
    end
  end
end
