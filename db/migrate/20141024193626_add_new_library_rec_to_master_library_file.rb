class AddNewLibraryRecToMasterLibraryFile < ActiveRecord::Migration
  def change
    add_column :master_library_files, :newlibraryrec, :boolean
  end
end
