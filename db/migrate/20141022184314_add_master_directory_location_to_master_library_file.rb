class AddMasterDirectoryLocationToMasterLibraryFile < ActiveRecord::Migration
  def change
    add_column :master_library_files, :master_directory_location, :string
  end
end
