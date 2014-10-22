class AddIndexOnLibraryFileSpec < ActiveRecord::Migration
  def change
    add_index :library_file_specs, [:artist, :album, :title]
  end
end
