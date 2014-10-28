def m_crosscheck_itunes
  v_process_name = 'crosscheck-itunes'
  m_setup_logging(v_process_name)
  
  # what if the file in the iTunes library is a "better" file than an existing library file?
  # by "better" I mean "higher bitrate, higher sample rate, etc.
  
  # Load up the Library with the iTunes library.
  puts '##################################################'
  puts '# m_process_dir:  Load up the Library            #'
  puts '# from LibraryRoot                               #'
  puts '##################################################'
  LibraryRoot.where(isitunes: true).find_each do |ar_lr_rec|
    m_process_dir(ar_lr_rec.name, ar_lr_rec.name)
  end
  
  # Create library file specs for anything in the Library
  puts '##################################################'
  puts '# m_process_file_specs:  Populate the file specs #'
  puts '# from the Library                               #'
  puts '##################################################'
  m_process_file_specs
  
  puts '##################################################'
  puts '# check to see if any file spec entries are      #'
  puts '# new to the iTunes library.                     #'
  puts '# Check the log to find any necessary actions    #'
  puts '##################################################'

  LibraryFileSpec.where(isitunes: true).where(newlibraryrec: true).find_each do |lfs|

    # puts "This file: #{lfs.artist} - #{lfs.album} - #{lfs.title}"
    v_existing_lib_count = LibraryFileSpec.where(artist: lfs.artist, album: lfs.album, title: lfs.title, isitunes: false).count
    # puts "Number of existing library recs with matching artist-album-title: #{existing_lib_count}"
    if v_existing_lib_count > 0
      m_log(v_process_name, 'Info', "iTunes LibraryFileSpec Id: #{lfs.id} for '#{lfs.artist} - #{lfs.album} - #{lfs.title}' is new in iTunes, already exists in the LibraryFileSpec, #{v_existing_lib_count} time(s).  No action needs to be taken.")
    elsif v_existing_lib_count == 0
      v_itunes_library_entry = m_find_fqfn(Library.find(lfs.idoflibraryrecord))
      m_log(v_process_name, 'Error', "iTunes Entry: '#{v_itunes_library_entry}' is new (maybe downloaded from iTunes?) and should be moved into a library and cataloged.")
    end
    
  end
  
  return true
end