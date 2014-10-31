class FixPlaylistSongs < ActiveRecord::Migration
  def change
    rename_column :playlist_songs, :master_libary_file_id, :master_library_file_id
  end
end
