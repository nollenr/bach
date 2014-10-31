def m_write_playlist(p_playlist_name)
    v_name = nil
    v_artist = nil
    v_composer = nil
    v_album = nil
    v_grouping = nil
    v_genre = nil
    v_size = nil
    v_time = nil
    v_disc_number = nil
    v_disc_count = nil
    v_track_number = nil
    v_track_count = nil
    v_year = nil
    v_date_modified = nil
    v_date_added = nil
    v_bit_rate = nil
    v_sample_rate = nil
    v_volume_adjustment = nil
    v_kind = nil
    v_equalizer = nil
    v_comments = nil
    v_plays = nil
    v_last_played = nil
    v_skips = nil
    v_last_skipped = nil
    v_my_rating = nil
    v_location = nil
    
  # read this from my LibaryList?  where is_playlist_directory is true?
  CSV.open("/media/nollenr-r7e64/playlists/"+p_playlist_name+".txt", "w", {col_sep: "\cI"}) do |f_csv|
    f_csv << ["Name",           "Artist",         "Composer",
              "Album",          "Grouping",       "Genre",
              "Size",           "Time",           "Disc Number",
              "Disc Count",     "Track Number",   "Track Count",
              "Year",           "Date Modified",  "Date Added",
              "Bit Rate",       "Sample Rate",    "Volume Adjustment",
              "Kind",           "Equalizer",      "Comments",
              "Plays",          "Last Played",    "Skips",
              "Last Skipped",   "My Rating",      "Location"]
    MasterLibraryFile.where(id: [28,47]).find_each do |rec_mlf|
      f_csv << [v_name,           v_artist,         v_composer,
                v_album,          v_grouping,       v_genre,
                v_size,           v_time,           v_disc_number,
                v_disc_count,     v_track_number,   v_track_count,
                v_year,           v_date_modified,  v_date_added,
                v_bit_rate,       v_sample_rate,    v_volume_adjustment,
                v_kind,           v_equalizer,      v_comments,
                v_plays,          v_last_played,    v_skips,
                v_last_skipped,   v_my_rating,      m_windows_fqfn(rec_mlf.master_directory_location)]
    end
  end
end
