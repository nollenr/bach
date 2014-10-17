class MasterLibraryFile < ActiveRecord::Base
  belongs_to :library, foreign_key: "idoflibraryrecord"
end
