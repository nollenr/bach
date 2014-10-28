def m_process_dir(p_entry, p_path, p_parent_entry_id = nil, p_running_as_update = false)
  
  p_running_as_update ? v_log_process="crosscheck-libraries" : v_log_process="create-libraries"
  # if p_parent_entry_id is null, then this better be
  # a directory, specifically a root directory, not a file!
  puts "Processing directory: #{p_entry}"
  puts "Processing path: #{p_path}"
  
  if Dir.exists?(p_path)
    # if it is a directory, create a new library record unless one already exists.
    unless myExistingRec = Library.where(name: p_entry, idofparent: p_parent_entry_id).first
      puts "     Creating entry in library..."
      m_log(v_log_process, 'Info', "Creating new directory: '#{p_entry}' on '#{p_path}'") if p_running_as_update
      # if p_parent_entry_id is null, the this is a root
      p_parent_entry_id.nil? ? p_isroot = true : p_isroot = false
      myExistingRec = Library.create(name: p_entry, idofparent: p_parent_entry_id, isroot: p_isroot, isleaf: false)
    end 
    
    # now change to that directory, and for each item call this script.
    Dir.foreach(p_path) do |file_or_dir|
      puts "     Working on #{file_or_dir}"
      next if file_or_dir.eql? '.' or file_or_dir.eql? '..'
      m_process_dir(file_or_dir, p_path + '/' + file_or_dir, myExistingRec.id, p_running_as_update) 
    end
    
  elsif File.exists?(p_path) # This is a file
    puts "     Processing file entry in library..."
    unless myExistingRec = Library.where(name: p_entry, idofparent: p_parent_entry_id).first
      puts "     Creating file entry in library..."
      m_log(v_log_process, 'Info', "Creating new leaf record: '#{p_entry}' on '#{p_path}'") if p_running_as_update
      # this is a file, set is leaf to true.
      myExistingRec = Library.create(name: p_entry, idofparent: p_parent_entry_id, isroot: false, isleaf: true)
    end 
  else
    # TODO: Error Processing
    puts "     Neither file nor directory #{p_path} exists"
  end
  
  return true # what if there was an error?
end


