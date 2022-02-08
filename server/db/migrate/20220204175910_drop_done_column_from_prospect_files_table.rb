class DropDoneColumnFromProspectFilesTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :prospect_files, :done
  end
end
