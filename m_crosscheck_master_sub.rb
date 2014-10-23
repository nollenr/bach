def m_crosscheck_master_sub(p_entry, p_path)

  if Dir.exists?(p_path)
    # If this is a directory, process all of the entries in the directory
    Dir.foreach(p_path) do |file_or_dir|
      # puts "Working on directory #{file_or_dir}"
      next if file_or_dir.eql? '.' or file_or_dir.eql? '..'
      retval = m_crosscheck_master_sub(file_or_dir, p_path + '/' + file_or_dir) 
    end
  
  # If this is not a directory, is it a file?  
  elsif File.exists?(p_path) # This is a file
    # puts "  Checking to see if the file is in library..."
    if myExistingRec = MasterLibraryFile.where(master_directory_location: p_path).first
      # m_log("crosscheck-master", "Info", "File #{p_path} exists on disk and in the library")
      # puts "      file entry in library..."
    else
      if caseInsensitive = MasterLibraryFile.where("upper(master_directory_location) = upper(?)", p_path).first
        m_log("crosscheck-master", "Warn", "Case mis-match: file '#{p_path}' is not the same as '#{caseInsensitive.master_directory_location}'")
      else
        m_log("crosscheck-master", "Error", "File on disk, '#{p_path}' not found in master library")
      # puts "      file entry NOT in library"
      end
    end
  
  else
    m_log("crosscheck-master", "Error", "  We have an error here... the entry '#{p_path}' is neither directory nor file")
  end
  
end