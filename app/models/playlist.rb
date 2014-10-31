class Playlist < ActiveRecord::Base
  
  has_many :playlist_songs
  has_many :master_library_files, through: :playlist_songs
  
end
