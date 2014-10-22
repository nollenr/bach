class AddUniqueIndextoLibraryRoot < ActiveRecord::Migration
  def change
    add_index :library_roots, :name, unique: true
  end
end
