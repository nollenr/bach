class Library < ActiveRecord::Base
  has_one :library_file_spec, foreign_key: "idoflibraryrecord"
  has_one :master_library_file, foreign_key: "idoflibraryrecord"
  
  # http://guides.rubyonrails.org/association_basics.html#self-joins
  has_many :childrenl, class_name: "Library", foreign_key: "idofparent"
  belongs_to :parentl, class_name: "Library", foreign_key: "idofparent"
end
