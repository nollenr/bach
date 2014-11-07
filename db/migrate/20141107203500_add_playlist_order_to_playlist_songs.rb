class AddPlaylistOrderToPlaylistSongs < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :playlist_order, :integer
  end
end
