require 'taglib'
load 'm_get_file_info.rb'
load 'm_find_fqfn.rb'

Library.where("isleaf = true").find_each do |myfile|
  file_fqfn = m_find_fqfn(myfile)
  v_hash = m_get_file_info(file_fqfn) 
  myLFS = LibraryFileSpec.new(:idoflibraryrecord => myfile.id, :filesizeinmb => v_hash[:file_size],
    :album => v_hash[:album], :artist => v_hash[:artist], :comment => v_hash[:comment],  
    :genre => v_hash[:genre], :title => v_hash[:title],   :track => v_hash[:track], 
    :year => v_hash[:year])
  myLFS.save
end
# require 'taglib'
#TagLib::FileRef.open(myFile) do |fileref|
#  tag = fileref.tag
#  puts tag.album
#  puts tag.artist
#  puts tag.comment
#  puts tag.genre
#  puts tag.title
#  puts tag.track
#  puts tag.year
#end
