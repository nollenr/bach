def m_crosscheck_libraries
  v_log_process = 'crosscheck-libraries'
  m_setup_logging(v_log_process)
=begin
  A.  Go through all of the libraries and make sure the files are 
      still on disk like they are supposed to be.
  B.  Go through all of the disk files in the different libraries
      and be sure there is an entry in the library for it. 
=end

  # Set up an array which is the pathname pieces of the master library root and the itunes root
  v_master_path_array = Pathname((LibraryRoot.where(ismaster: true).pluck(:name).first).to_s).each_filename.to_a
  v_itunes_path_array = Pathname((LibraryRoot.where(isitunes: true).pluck(:name).first).to_s).each_filename.to_a


  Library.where(isleaf: true).each do |leaf| 
    fqfn = m_find_fqfn(leaf)
    # If this is true, then this fqfn has the master library path
    next if (!v_master_path_array.empty?) & (v_master_path_array & Pathname(fqfn).each_filename.to_a == v_master_path_array)
    # If this is true, then this fqfn has the itunes library path
    next if (!v_itunes_path_array.empty?) & (v_itunes_path_array & Pathname(fqfn).each_filename.to_a == v_itunes_path_array)

    if ! File.exists?(fqfn) 
      m_log(v_log_process, "Error", "The library record (leaf id:#{leaf.id}) for #{leaf.name} does not exist on disk at '#{fqfn}'")
    end
  end # End Library.where
  
  LibraryRoot.where(ismaster: false, isitunes: false).each do |rootrec|
    m_process_dir(rootrec.name, rootrec.name, nil, true)
  end
  
  
  return true
end #End Def