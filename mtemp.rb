def mtemp
  musicbygenrehash = Hash.new
  MasterLibraryFile.select(:genre).group(:genre).each do |genre_list|
    musicbygenrehash[genre_list.genre] = MasterLibraryFile.select(:artist, :album, :title).where(genre: genre_list.genre)
  end
  # musicbygenrehash["Classical"].each {|mlf| puts mlf.artist }
  musicbygenrehash.each_key do |genreitem|
    puts '<h2><a href="#">#{genreitem}</a></h2>'
    puts '  <div>'
    musicbygenrehash[genreitem].each {|gih| puts "    <li>#{gih.artist}</li>" }
    puts '  </div>'
  end
  return true
end