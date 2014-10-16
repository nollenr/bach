class AddUniqueIndexToMasterLibraryFiles < ActiveRecord::Migration
  def change
    add_index :master_library_files, [:artist, :album, :title], unique: true
  end
end
