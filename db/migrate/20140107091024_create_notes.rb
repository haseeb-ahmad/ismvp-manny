class CreateNotes < ActiveRecord::Migration
	def change
		create_table :notes do |t|
			t.text :note, :default => nil
			t.references :contact, index: true

			t.timestamps
		end
	end
end
