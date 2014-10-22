class ChangeNewLibraryRecNotNullOnLibraryAndLibraryFileSpec < ActiveRecord::Migration
  def change
    change_column :libraries, :newlibraryrec, :boolean, null: false
    change_column :library_file_specs, :newlibraryrec, :boolean, null: false
  end
end
