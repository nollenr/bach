def m_get_file_info (p_fqfn)
=begin
  input is a fully qualified file name
=end
  if File.exists?(p_fqfn)
    v_val_hash = Hash.new
    v_val_hash[:file_size] = File.size(p_fqfn)
    TagLib::FileRef.open(p_fqfn) do |fileref|
      tag = fileref.tag
      v_val_hash[:album] =  tag.album
      v_val_hash[:artist] = tag.artist
      v_val_hash[:comment] = tag.comment
      v_val_hash[:genre] = tag.genre
      v_val_hash[:title] = tag.title
      v_val_hash[:track] = tag.track
      v_val_hash[:year] = tag.year
    end
    return v_val_hash
  else
    return nil
  end
end

