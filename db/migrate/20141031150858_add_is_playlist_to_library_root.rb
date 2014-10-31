class AddIsPlaylistToLibraryRoot < ActiveRecord::Migration
  def change
    add_column :library_roots, :isplaylist, :boolean, default: false
  end
end
