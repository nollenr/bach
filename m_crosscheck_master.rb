def m_crosscheck_master
  m_setup_logging("crosscheck-master")
=begin
  Two Parts:
  A.  Go through the table (MasterLibraryFile) and check
      to be sure all of the files still exist on disk.
      If not, then check the original library location,
      see if it still exists there.
      If not, check other library locations and see
      if it exists in any known location.
      Do I want to copy the file to the master location
      if I find it?  What action do I want to take.
  B.  Go through the filesystem and see if there are
      any files that don't exist in the table (MasterLibaryFIle).
      If so... should they be added to a library... which one?
      If so... should MasterLibraryFile be updated (NO).  This
      should happen as part of the crosscheck-library. 
=end
=begin
  PART A 
=end
  MasterLibraryFile.find_each do |mlf|
    if ! File.exists?(mlf.master_directory_location) 
      # puts "DOES NOT EXIST: #{mlf.artist}-#{mlf.album}-#{mlf.title}"
      if File.exists?(mlf.original_directory_location)
        m_log("crosscheck-master", "Error", "The master record (id:#{mlf.id}) for #{mlf.artist}-#{mlf.album}-#{mlf.title} does not exist in the master library on disk at '#{mlf.master_directory_location}', but does exist in the original library location '#{mlf.original_directory_location}'")
        puts "File does exist in its original location"
      else
        m_log("crosscheck-master", "Error", "The master record (id:#{mlf.id}) for #{mlf.artist}-#{mlf.album}-#{mlf.title} does not exist in the master library on disk at '#{mlf.master_directory_location}' and does NOT exist in the original library location '#{mlf.original_directory_location}'")
        puts "File does NOT exist in its original location"
      end
    end
  end
=begin
  PART B 
=end
  LibraryRoot.where(ismaster: true).each do |masterlib|
    m_crosscheck_master_sub(masterlib.name, masterlib.name)
  end
  return true
end