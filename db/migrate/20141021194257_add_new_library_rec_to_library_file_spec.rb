class AddNewLibraryRecToLibraryFileSpec < ActiveRecord::Migration
  def change
    add_column :library_file_specs, :newlibraryrec, :boolean, default: true
  end
end
