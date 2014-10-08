class LibraryFileSpec < ActiveRecord::Base
  belongs_to :library, foreign_key: "idoflibraryrecord"
  
  def self.has_title
    where.not(title: nil)
  end
  def self.title_not_like_track
    # where("upper(title) not like 'TRACK%'")
    where.not("upper(title) like 'TRACK%'")
  end
  def self.default_group_by
    group(:title, :album, :artist)
  end
  def self.add_track_to_group_by
    group(:track)
  end
  def self.with_file_name
    select(:name).joins(:library)
  end
end
