def m_create_physical_master(p_root)
  
  # Why did I choose libraries.name for the filename of the file?
  MasterLibraryFile.select("master_library_files.*, libraries.name").joins(:library).where(newlibraryrec: true).where.not("artist is null or album is null or title is null").each do |filerec|
    puts "Original: #{filerec.original_directory_location}"
    master_file = p_root+'/'+filerec.artist.gsub(/[^0-9A-Za-z ]/, '')+'/'+filerec.album.gsub(/[^0-9A-Za-z ]/, '')+'/'+filerec.name
    puts "  New Location: #{master_file}"
    FileUtils.mkdir_p(File.dirname(master_file))
    FileUtils.copy_file(filerec.original_directory_location, master_file)
    MasterLibraryFile.where(id: filerec.id).update_all(master_directory_location: master_file, newlibraryrec: false)
  end  
=begin
    if not File.identical?(filerec.original_directory_location, master_file)
      puts "ERROR:  Files not the same"
      break
    end
=end
=begin
  Should all unknowns go into their own directory (one-to-one directory: file), or should all unknowns go into the
  same directory (one directory, many files)?
  Currently, each unknown is going into it's own directory 
=end
  MasterLibraryFile.select("master_library_files.*, libraries.name, nextval('artist_seq') as artist_seq, nextval('album_seq') as album_seq").joins(:library).where(newlibraryrec: true).where("artist is null or album is null or title is null").each do |filerec|
    filerec.artist.nil? ? v_artist = 'artist' + filerec.artist_seq.to_s.rjust(5,'0') : v_artist = filerec.artist
    filerec.album.nil? ? v_album = 'album' + filerec.album_seq.to_s.rjust(5,'0') : v_album = filerec.album
    # title is not actually used in the name
    # filerec.title.nil? ? v_title = 'title' + filerec.title_seq.to_s.rjust(5,'0') : v_title = filerec.title
    master_file = p_root+'/'+v_artist.gsub(/[^0-9A-Za-z ]/, '')+'/'+v_album.gsub(/[^0-9A-Za-z ]/, '')+'/'+filerec.name
    puts "Original: #{filerec.original_directory_location}"
    puts "  New Location: #{master_file}"
    FileUtils.mkdir_p(File.dirname(master_file))
    FileUtils.copy_file(filerec.original_directory_location, master_file)
    MasterLibraryFile.where(id: filerec.id).update_all(master_directory_location: master_file, newlibraryrec: false)
  end
  return true

end
