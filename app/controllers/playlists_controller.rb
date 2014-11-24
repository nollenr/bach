class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
    # @mlfs = MasterLibraryFile.where("artist is not null and album is not null and title is not null").order("artist", "album", "title").all
    @musicGrouped = Hash.new
    # MasterLibraryFile.select("genre as genre, coalesce(genre, 'Unknown Genre') as genre_display").group(:genre).each do |genre_list|
    #  @musicGrouped[genre_list.genre_display] = MasterLibraryFile.select(:id, :artist, :album, :title).where(genre: genre_list.genre).where("artist is not null and album is not null and title is not null").order(:artist, :album, :title)
    # end
    MasterLibraryFile.select("artist as artist, coalesce(artist, 'Unknown Artist') as artist_display").where("substr(artist,1,1) between 'A' and 'C'").group(:artist).order(:artist).each do |artist_list|
      @musicGrouped[artist_list.artist_display] = MasterLibraryFile.select(:id, "coalesce(artist, 'Unknown Artist') as artist", "coalesce(album, 'Unknown Album') as album", "coalesce(title, 'Unknown Title') as title").where(artist: artist_list.artist).order(:artist, :title)
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
    if params[:term]
      # @playlist = Playlist.order(:name).where('upper(name) like upper(:name)', {name: "%#{params[:term]}%"}).pluck(:id, :name)
      @playlist = Playlist.order(:name).where('upper(name) like upper(:name)', {name: "%#{params[:term]}%"}).pluck(:name, :id)
    else
      @playlist = Playlist.all.order(:name).pluck(:id, :name)
    end
    @reconstructed_playlist=[]
    @playlist.each do |list, id|
      @reconstructed_playlist.push({value: list, id: id})
    end    
    render :json => @reconstructed_playlist
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
  
  # Many-To-Many Through Playlist_songs 
  def update_cart
    # Need to do a complete refresh of a playlist everytime.
    # The playlist could have items added, deleted or re-arranged.
    # Does the playlist id exist?  If not, create it, if it does, delete all the playlist songs
    # Difference between id being null and id not being found in the playlists?
    # If the parameter "id" is null, should I check the name of the playlist to be sure it's not there?
    #  or can I rely on my GUI to ensure that is true for me?
    #  I'm not going to check to see if the playlist id can be found.  If it comes in the parameter list,
    #  then it is in the Playlist table, if not, then I'll assume the playlist name doesn't exist.  
    if params[:playlist][:id].empty?
      logger.debug("Creating new playlist")
      v_new_playlist = Playlist.new
      v_new_playlist.name = params[:playlist][:name]
      v_new_playlist.save!
      v_playlist_id = v_new_playlist.id
    else
      logger.debug("param[id] is NOT empty")
      v_playlist_id = params[:playlist][:id]
    end
    
    @musiclist = params[:playlist][:playlist_songs_attributes]
    logger.debug(@musiclist)
    PlaylistSong.where(playlist_id: v_playlist_id).delete_all
    @musiclist.each do |key, mlitem|
      logger.debug("mlitem")
      logger.debug(mlitem.inspect)
      logger.debug("Inserting position: " + mlitem["playlist_order"].to_s + " id: " + mlitem["master_library_file_id"].to_s)
      PlaylistSong.create(
        playlist_id: v_playlist_id,
        playlist_order: mlitem["playlist_order"],
        master_library_file_id: mlitem["master_library_file_id"] )
    end
    respond_to do |format|
      format.js
    end
  end

  def get_playlist_songs
    @playlist_songs = PlaylistSong.select("playlist_songs.*, master_library_files.title, master_library_files.genre").joins(:master_library_file).where(playlist_id: params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def get_music_list
      # {value: "Artist-Album-Song", id: 1},
      # {value: "Album-Song", id: 2},
      # {value: "Song", id: 3},
      # {value: "Genre", id: 4}
    logger.debug("params[:id]: #{params[:id]}")
      @musicSegment=params[:list].split("-");
      @musicGrouped = Hash.new
      MasterLibraryFile.select("artist as artist, coalesce(artist, 'Unknown Artist') as artist_display").where("artist between :start and :finish", start: @musicSegment[0], finish: @musicSegment[1]).group(:artist).order(:artist).each do |artist_list|
        @musicGrouped[artist_list.artist_display] = MasterLibraryFile.select(:id, :artist, :album, :title).where(artist: artist_list.artist).where("artist is not null and album is not null and title is not null").order(:artist, :title)
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
