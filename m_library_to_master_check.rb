def m_library_to_master_check
  number_of_library_tracks = LibraryFileSpec.where.not("artist is null or album is null or title is null").group(:artist, :album, :title).count.count
  puts "Number of distinct tracks from LibraryFileSpec: #{number_of_library_tracks}"
  
  number_of_master_tracks = MasterLibraryFile.where.not("artist is null or album is null or title is null").group(:artist, :album, :title).count.count
  puts "Number of distinct tracks from MasterLibraryFile: #{number_of_master_tracks}"
  
  puts "Number of racks missing or duplicated between the Library and Master: #{number_of_library_tracks - number_of_master_tracks}"
end
