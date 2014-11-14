class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
    # @mlfs = MasterLibraryFile.where("artist is not null and album is not null and title is not null").order("artist", "album", "title").all
    @musicbygenrehash = Hash.new
    MasterLibraryFile.select(:genre).group(:genre).each do |genre_list|
      @musicbygenrehash[genre_list.genre] = MasterLibraryFile.select(:id, :artist, :album, :title).where(genre: genre_list.genre).where("artist is not null and album is not null and title is not null").order(:artist, :album, :title)
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end
  
  def jsonplaylist
    # @@data = File.read("countries.json")
    # render :json => @@data
    @playlist = Playlist.all.order(:name).pluck(:id, :name)
    render :json => @playlist
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render :show, status: :created, location: @playlist }
      else
        format.html { render :new }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy
    respond_to do |format|
      format.html { redirect_to playlists_url, notice: 'Playlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # Testing Ajax Functionality
  def update_cart
    # Need to do a complete refresh of a playlist everytime.
    # The playlist could have items added, deleted or re-arranged.
    @musiclist = params[:playlist][:playlist_songs_attributes]
    logger.debug(@musiclist)
    PlaylistSong.where(playlist_id: playlist_params[:id]).delete_all
    @musiclist.each do |key, mlitem|
      logger.debug("mlitem")
      logger.debug(mlitem.inspect)
      logger.debug("Inserting position: " + mlitem["playlist_order"].to_s + " id: " + mlitem["master_library_file_id"].to_s)
      PlaylistSong.create(
        playlist_id: playlist_params[:id],
        playlist_order: mlitem["playlist_order"],
        master_library_file_id: mlitem["master_library_file_id"] )
    end
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      # This also works and is more intuitive for me.
      # params[:playlist].permit(:name)
      # Example of Parameters:
        # {"playlist"=>
        #   {"id"=>"16",
        #    "playlist_songs_attributes"=>
        #       {"0"=>{"playlist_order"=>"0", "master_library_file_id"=>"133"},
        #        "1"=>{"playlist_order"=>"1", "master_library_file_id"=>"762"},
        #        "2"=>{"playlist_order"=>"2", "master_library_file_id"=>"671"}
        #       }
        #   }
        # }
      params.require(:playlist).permit(:id, :name, {:playlist_songs_attributes => [:playlist_order, :master_library_file_id]})
    end
end
