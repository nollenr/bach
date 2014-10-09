LibraryFileSpec.where(title: "White Christmas").has_title.title_not_like_track.default_group_by.order(:title, :album, :artist).count.each do |trackset, count|
   puts "#{trackset.inspect} #{count.inspect}"
end
