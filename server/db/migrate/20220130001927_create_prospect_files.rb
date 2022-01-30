class CreateProspectFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :prospect_files do |t|
      t.integer :total
      t.integer :done

      t.timestamps
    end
  end
end
