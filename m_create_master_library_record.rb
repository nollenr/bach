def m_create_master_library_record(libraryfilespecrec)
    
    file_fqfn = m_find_fqfn(Library.find(libraryfilespecrec.idoflibraryrecord))
    MasterLibraryFile.create(
      idoflibraryrecord: libraryfilespecrec.idoflibraryrecord,
      idoflibaryfilespecrecord: libraryfilespecrec.id,
      filesizeinmb: libraryfilespecrec.filesizeinmb,
      artist: libraryfilespecrec.artist,
      album: libraryfilespecrec.album,
      length: libraryfilespecrec.length,
      comment: libraryfilespecrec.comment,
      genre: libraryfilespecrec.genre,
      title: libraryfilespecrec.title,
      track: libraryfilespecrec.track,
      year: libraryfilespecrec.year,
      bitrate: libraryfilespecrec.bitrate,
      channels: libraryfilespecrec.channels,
      sample_rate: libraryfilespecrec.sample_rate,
      file_extension: libraryfilespecrec.file_extension,
      library_priority: libraryfilespecrec.library_priority,
      original_directory_location: file_fqfn)
      
      return true
end
