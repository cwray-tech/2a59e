class AddForeignKeyToProspectsTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :prospects, :prospect_file, foreign_key: true
  end
end
