
ext_hash = Hash.new

Library.where("isleaf = true").where.not(id: LibraryFileSpec.select("idoflibraryrecord")).find_each do |myfile|
  v_file_extension = m_file_extension(myfile.name)
  next if v_file_extension.nil? # No extension on this file... skip it.
  ext_hash.has_key?(v_file_extension) ?  ext_hash[v_file_extension] += 1 : ext_hash[v_file_extension] = 1
end

puts ext_hash.inspect

