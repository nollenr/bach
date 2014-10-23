def m_process_libraries
  LibraryRoot.where(ismaster: false).find_each do |library_entry|
    m_process_dir(library_entry.name, library_entry.name)    
  end
    
end