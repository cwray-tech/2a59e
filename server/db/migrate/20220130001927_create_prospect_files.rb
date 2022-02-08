class CreateProspectFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :prospect_files do |t|
      t.integer :email_index, null: false
      t.integer :first_name_index, null: true
      t.integer :last_name_index, null: true
      t.boolean :force, default: false
      t.boolean :has_headers, default: false
      t.integer :total, default: 0
      t.integer :done, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
