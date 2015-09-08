class CreateSectionEdits < ActiveRecord::Migration
  def change
   create_table :section_edits do |t|
			t.integer :admin_user_id
			t.integer :section_id
	    t.string :summary
      t.timestamps null: false
    end
		add_foreign_key :section_edits, :admin_users
		add_foreign_key :section_edits, :sections
  end
end
