class MasterLibraryFileController < ApplicationController
  def index
    @mlfs = MasterLibraryFile.order("artist", "album", "title").all
    @pls = Playlist.all
  end
end
