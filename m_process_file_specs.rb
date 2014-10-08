
ext_hash = Hash.new
FileExtension.all.map{|x| ext_hash[x.extension] = x.process_tag}

Library.where("isleaf = true").where.not(id: LibraryFileSpec.select("idoflibraryrecord")).find_each do |myfile|
  v_file_extension = m_file_extension(myfile.name)
  next if v_file_extension.nil? # No extension on this file... skip it.
  if !ext_hash.has_key?(v_file_extension) # if the extension on this file is not in the list, issue a warning and skip it
    puts "***********************************"
    puts "The extension #{v_file_extension} is not in the list of known extensions (file_extensions)."
    puts "Consider running m_extension_list to add it and then determining if it has a valid label (true) or not (false)."
    puts "***********************************"
    ext_hash[v_file_extension] = false
    next
  end
  next unless ext_hash[v_file_extension] # if process tag is false

=begin
  find the fully qualified file name (m_find_fqfn)
  get the tag of the file
  create a new record in the file spec model
=end
  file_fqfn = m_find_fqfn(myfile)
  v_hash = m_get_file_info(file_fqfn)
  myLFS = LibraryFileSpec.create(    :idoflibraryrecord => myfile.id, :filesizeinmb => v_hash[:file_size],
    :album => v_hash[:album],     :artist => v_hash[:artist], :comment => v_hash[:comment],
    :genre => v_hash[:genre],     :title => v_hash[:title],   :track => v_hash[:track],
    :year => v_hash[:year],       :length => v_hash[:length], :channels => v_hash[:channels],
    :bitrate => v_hash[:bitrate], :sample_rate => v_hash[:sample_rate])

end