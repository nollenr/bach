def m_process_libraries
  LibraryRoot.find_each do |library_entry|
    m_process_dir(library_entry.name, library_entry.name)    
  end
    
end