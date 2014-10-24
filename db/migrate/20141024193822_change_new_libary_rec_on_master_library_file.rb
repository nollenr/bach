class ChangeNewLibaryRecOnMasterLibraryFile < ActiveRecord::Migration
  def change
    change_column :master_library_files, :newlibraryrec, :boolean, {default: true, null: false}
  end
end
