class LibraryFileSpec < ActiveRecord::Base
  belongs_to :library, foreign_key: "idoflibraryrecord"
  
  #############################################
  # SCOPES                                    #
  #############################################
  
  ##############################################################
  # (Title is not null / Title not like 'TRACK%')              #
  # config items 2 & 3                                         #
  ##############################################################

  # Examples:
  # LibraryFileSpec.has_title.title_not_like_track.default_group_by.count  <= Returns a hash of array=>count
  # LibraryFileSpec.has_title.title_not_like_track.default_group_by.with_parent_dir.count
  # LibraryFileSpec.has_title.title_not_like_track.default_group_by.add_track_to_group_by.count
  
  def self.has_title
    where.not(title: nil)
  end
  
  def self.title_not_like_track
    # where("upper(title) not like 'TRACK%'")
    where.not("upper(title) like 'TRACK%'")
  end
  
  # all of the following are to be used with a ".count"
  def self.default_group_by
    group(:artist, :album, :title)
  end
  
  def self.add_track_to_group_by
    group(:track)
  end
  
  # The following scopes are mutually exclusive
  def self.with_filename
    joins(:library).group("libraries.name")
  end
  def self.with_parent_dir
    joins(library: :parentl).group("parentls_libraries.name")
  end
  def self.with_filename_and_parent_dir
    joins(library: :parentl).group("libraries.name", "parentls_libraries.name")
  end
  
  ##############################################################
  # Second Loop (union with the above)                         #
  # config item 4                                              #
  ##############################################################
  def self.include_unknowns
    where(title: nil)
  end

  ##############################################################
  # Third and 4th loops (union with the above)                 #
  # config item 5                                              #
  ##############################################################  
  def self.titles_like_track
    where("upper(title) like 'TRACK%'").where.not(album: nil).group(:artist, :album, :title).count
  end
  def self.titles_like_track_no_album
    where("upper(title) like 'TRACK%'").where(album: nil)
  end
end
