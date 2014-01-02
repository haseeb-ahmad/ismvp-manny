class CreateContactNotes < ActiveRecord::Migration
  def change
    create_table :contact_notes do |t|
      t.string :note
      t.references :contact, index: true

      t.timestamps
    end
  end
end
