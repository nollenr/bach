class AddUniqueIndexOnLibraryFileSpecs < ActiveRecord::Migration
  def change
    add_index :library_file_specs, :idoflibraryrecord, :unique => true
  end
end
