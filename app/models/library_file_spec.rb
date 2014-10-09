class LibraryFileSpec < ActiveRecord::Base
  belongs_to :library, foreign_key: "idoflibraryrecord"
  
  #############################################
  # SCOPES                                    #
  #############################################
  def self.has_title
    where.not(title: nil)
  end
  def self.title_not_like_track
    # where("upper(title) not like 'TRACK%'")
    where.not("upper(title) like 'TRACK%'")
  end
  
  # all of the following are to be used with a ".count"
  def self.default_group_by
    group(:title, :album, :artist)
  end
  def self.add_track_to_group_by
    group(:track)
  end
  
  # The following two scopes are mutually exclusive
  def self.with_filename
    joins(:library).group("libraries.name")
  end
  def self.with_parent_dir
    joins(library: :parentl).group("parentls_libraries.name")
  end
  def self.with_filename_and_parent_dir
    joins(library: :parentl).group("libraries.name", "parentls_libraries.name")
  end
end
