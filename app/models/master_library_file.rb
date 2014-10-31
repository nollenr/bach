class MasterLibraryFile < ActiveRecord::Base

  belongs_to :library, foreign_key: "idoflibraryrecord"
  
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  
end
