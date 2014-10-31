class PlaylistSong < ActiveRecord::Base
  
  belongs_to :playlist
  belongs_to :master_library_file
  
end
