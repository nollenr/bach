def m_crosscheck_libraries
  v_log_process = 'crosscheck-libraries'
  m_setup_logging(v_log_process)
=begin
  A.  Go through all of the libraries and make sure the files are 
      still on disk like they are supposed to be.
  B.  Go through all of the disk files in the different libraries
      and be sure there is an entry in the library for it. 
=end
  Library.where(isleaf: true).each do |leaf| 
    fqfn = m_find_fqfn(leaf)
    if ! File.exists?(fqfn) 
      m_log(v_log_process, "Error", "The library record (leaf id:#{leaf.id}) for #{leaf.name} does not exist on disk at '#{fqfn}'")
    end
  end # End Library.where
  
  LibraryRoot.where(ismaster: false, isitunes: false).each do |rootrec|
    m_process_dir(rootrec.name, rootrec.name, nil, true)
  end
  
  
  return true
end #End Def