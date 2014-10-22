def m_create_or_update_master_library
  LibraryFileSpec.where(newlibraryrec: true).where(ismaster: false).has_title.title_not_like_track.default_group_by.count.each do |track, num_lib_entries|
    # puts track.inspect
    v_artist = track[0]
    v_album = track[1]
    v_title = track[2]
    if num_lib_entries == 1
      # puts "One entry found for #{track.inspect}.  Adding to library"
      myrec = LibraryFileSpec.where(artist: v_artist, album: v_album, title: v_title).first
      # puts myarrln.inspect
      # puts "class: #{myarr.class} id: #{myarr.id}  comment: #{myarr.comment}"
    else
      # puts "Since there's more than one track for #{track.inspect}, I'll have to search for the right one to add to the master library."
      myrec = LibraryFileSpec.find_by_sql(["with max_bitrate as (select max(bitrate) bitrate from library_file_specs where artist = :v_artist and album = :v_album and title = :v_title),
              best_file_extension as (select extension, max_bitrate.bitrate bitrate from file_extensions, max_bitrate where sort_order = (select min(sort_order) from file_extensions where extension in (select file_extension from library_file_specs lfs where artist = :v_artist and album = :v_album and title = :v_title and lfs.bitrate = max_bitrate.bitrate)))
              select *
              from library_file_specs lfs--, max_bitrate, best_file_extension
              where artist = :v_artist
              and album = :v_album
              and title = :v_title
              --and lfs.bitrate = max_bitrate.bitrate
              --and lfs.file_extension = best_file_extension.extension
              and lfs.id in (
              select min(id)
              from library_file_specs lfs, best_file_extension
              where artist = :v_artist and album = :v_album and title = :v_title
              and (lfs.file_extension,lfs.bitrate) = (best_file_extension.extension, best_file_extension.bitrate)
              )", {v_artist: v_artist, v_album: v_album, v_title: v_title}] ).first
      #if myrec is nil, then something went wrong... probably no sort order on the file type
      # in that case, just select which ever record comes up first
      if not myrec
        myrec = LibraryFileSpec.where(artist: v_artist, album: v_album, title: v_title).first
      end
    end
    m_create_master_library_record(myrec)
    myarrayofid = LibraryFileSpec.where(artist: v_artist, album: v_album, title: v_title).ids
    LibraryFileSpec.where(id: myarrayofid).update_all(newlibraryrec: false)
    Library.where(id: LibraryFileSpec.select("idoflibraryrecord").where(id: myarrayofid)).update_all(newlibraryrec: false)
  end
  
  LibraryFileSpec.where(newlibraryrec: true).where(ismaster: false).include_unknowns.each do |myrec|
    m_create_master_library_record(myrec)
    myrec.update!(newlibraryrec: false)
    Library.where(id: myrec.idoflibraryrecord).update_all(newlibraryrec: false)
  end
  
  LibraryFileSpec.where(newlibraryrec: true).where(ismaster: false).titles_like_track.each do |track, num_lib_entries|
    v_artist = track[0]
    v_album = track[1]
    v_title = track[2]
    myrec = LibraryFileSpec.where(artist: v_artist, album: v_album, title: v_title).first
    m_create_master_library_record(myrec)    
    myarrayofid = LibraryFileSpec.where(artist: v_artist, album: v_album, title: v_title).ids
    LibraryFileSpec.where(id: myarrayofid).update_all(newlibraryrec: false)
    Library.where(id: LibraryFileSpec.select("idoflibraryrecord").where(id: myarrayofid)).update_all(newlibraryrec: false)
  end
  
  LibraryFileSpec.where(newlibraryrec: true).where(ismaster: false).titles_like_track_no_album.each do |myrec|
    m_create_master_library_record(myrec)
    myrec.update!(newlibraryrec: false)
    Library.where(id: myrec.idoflibraryrecord).update_all(newlibraryrec: false)
  end
  
  return true
end