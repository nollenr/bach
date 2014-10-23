class ChangeMasterDirectoryLocationToTextOnMasterLibraryFile < ActiveRecord::Migration
  def change
    change_column :master_library_files, :master_directory_location, :text
  end
end
