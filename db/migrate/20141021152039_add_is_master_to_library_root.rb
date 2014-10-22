class AddIsMasterToLibraryRoot < ActiveRecord::Migration
  def change
    add_column :library_roots, :ismaster, :boolean, null: false
  end
end
