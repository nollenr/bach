class AddIsMasterDefaultToLibraryRoot < ActiveRecord::Migration
  def change
    change_column :library_roots, :ismaster, :boolean, default: false
  end
end
