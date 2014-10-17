def m_create_physical_master(p_root)
  MasterLibraryFile.select("master_library_files.*, libraries.name").joins(:library).where.not("artist is null or album is null or title is null").each do |filerec|
    puts "Original: #{filerec.original_directory_location}"
    master_file = p_root+'/'+filerec.artist.gsub(/[^0-9A-Za-z ]/, '')+'/'+filerec.album.gsub(/[^0-9A-Za-z ]/, '')+'/'+filerec.name
    puts "  New Location: #{master_file}"
    FileUtils.mkdir_p(File.dirname(master_file))
    FileUtils.copy_file(filerec.original_directory_location, master_file)
=begin
    if not File.identical?(filerec.original_directory_location, master_file)
      puts "ERROR:  Files not the same"
      break
    end
=end
  end
  return true
end
