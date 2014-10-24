def m_get_file_info (p_fqfn)
=begin
  input is a fully qualified file name
=end
  if File.exists?(p_fqfn)
    v_val_hash = Hash.new
    v_val_hash[:file_size] = File.size(p_fqfn)
    TagLib::FileRef.open(p_fqfn) do |fileref|
      prop = fileref.audio_properties
      v_val_hash[:bitrate] = prop.bitrate
      v_val_hash[:channels] = prop.channels
      v_val_hash[:length] = prop.length
      v_val_hash[:sample_rate] = prop.sample_rate

      tag = fileref.tag
      tag.album ? v_val_hash[:album] =  tag.album.to_s.strip : v_val_hash[:album] = nil
      tag.artist ? v_val_hash[:artist] = tag.artist.to_s.strip : v_val_hash[:artist] = nil
      tag.comment ? v_val_hash[:comment] = tag.comment.to_s.strip : v_val_hash[:comment] = nil
      tag.genre ? v_val_hash[:genre] = tag.genre.to_s.strip : v_val_hash[:genre] = nil
      tag.title ? v_val_hash[:title] = tag.title.to_s.strip : v_val_hash[:title] = nil
      v_val_hash[:track] = tag.track
      v_val_hash[:year] = tag.year
    end
    return v_val_hash
  else
    return nil
  end
end

