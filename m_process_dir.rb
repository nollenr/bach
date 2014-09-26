def m_process_dir(p_dir_name, p_parent_id = nil)
=begin
  method to recursively read through a given directory
  structure and parse it into the "Library" model
  
  a "top level" directory will not have an "idofparent", 
  but the "isroot" flag will be set to true.

  files will all have "isleaf" set to true which indicates
  that it is a file and that there are no children for this
  library entry.

  unfortunately, empty directories may also be "leafs",
  but the "isleaf" will not be set for these phenomenon
=end
  if p_parent_id.nil?
    myLibItem = Library.new
    myLibItem.name = Dir.pwd
    myLibItem.isroot = true
    myLibItem.save
    v_parent_id = myLibItem.id
  else
    v_parent_id = p_parent_id
  end
  Dir.foreach(p_dir_name) do |x|
    puts "Entry #{x}"
    next if x.eql? '.' or x.eql? '..' # do not add '.' and '..' to the library

    # The next 3 lines are the same for files and directories
    myLibItem = Library.new
    myLibItem.idofparent = v_parent_id
    myLibItem.name = x
    if Dir.exists?(x)
      # puts "  Directory"
      myLibItem.save
      Dir.chdir(x) do
        m_process_dir(Dir.pwd, myLibItem.id) # recursion
      end
    elsif File.exists?(x)
      # puts "  File"
      myLibItem.isleaf = true
      myLibItem.save
    else
      # TODO: Error processing
      puts "  Unknown"
    end
  end
  return true
end


