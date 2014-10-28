def m_process_libraries(p_master = false, p_isitunes = false)
  
  LibraryRoot.where(ismaster: p_master, isitunes: p_isitunes).find_each do |library_entry|
    m_process_dir(library_entry.name, library_entry.name)    
  end
    
end