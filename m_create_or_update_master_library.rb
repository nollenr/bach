def m_create_or_update_master_library
  LibraryFileSpec.has_title.title_not_like_track.default_group_by.count.each do |track, num_lib_entries|
    # puts track.inspect
    if num_lib_entries == 1
      # puts "One entry found for #{track.inspect}.  Adding to library"
      # myarr = LibraryFileSpec.where(artist: track[0], album: track[1], title: track[2]).first
      # puts myarrln.inspect
      # puts "class: #{myarr.class} id: #{myarr.id}  comment: #{myarr.comment}"
    else
      puts "Since there's more than one track for #{track.inspect}, I'll have to search for the right one to add to the master library."
    end
  end
  return nil
end