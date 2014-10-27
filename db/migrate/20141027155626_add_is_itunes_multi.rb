class AddIsItunesMulti < ActiveRecord::Migration
  def change
    add_column :library_roots, :isitunes, :boolean, default: false
    add_column :library_file_specs, :isitunes, :boolean, default: false
    LibraryRoot.reset_column_information
    LibraryRoot.update_all(isitunes: false)
    LibraryFileSpec.reset_column_information
    LibraryFileSpec.update_all(isitunes: false)
    change_column :library_roots, :isitunes, :boolean, null: false
    change_column :library_file_specs, :isitunes, :boolean, null: false
  end
end
