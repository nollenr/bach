def m_file_extension(p_path)
=begin
 method to return the file extension of a file (potentially a fully qualified file name) 
 or nil if there is no extension 
=end
  return File.extname(p_path)
end