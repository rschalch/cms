class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
			t.integer :subject_id
      t.string :name
			t.string :permalink
      t.integer :position
      t.boolean :visible, default: false
      t.timestamps null: false
    end
    add_foreign_key :pages, :subjects
		add_index :pages, :permalink
  end
end