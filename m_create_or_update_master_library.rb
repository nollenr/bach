def m_create_or_update_master_library
  LibraryFileSpec.has_title.title_not_like_track.default_group_by.count.each do |track, num_lib_entries|
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
    file_fqfn = m_find_fqfn(Library.find(myrec.idoflibraryrecord))
    MasterLibraryFile.create(
      idoflibraryrecord: myrec.idoflibraryrecord,
      idoflibaryfilespecrecord: myrec.id,
      filesizeinmb: myrec.filesizeinmb,
      artist: myrec.artist,
      album: myrec.album,
      length: myrec.length,
      comment: myrec.comment,
      genre: myrec.genre,
      title: myrec.title,
      track: myrec.track,
      year: myrec.year,
      bitrate: myrec.bitrate,
      channels: myrec.channels,
      sample_rate: myrec.sample_rate,
      file_extension: myrec.file_extension,
      library_priority: myrec.library_priority,
      original_directory_location: file_fqfn)
  end
  return nil
end