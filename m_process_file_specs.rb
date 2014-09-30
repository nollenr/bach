require 'taglib'
load 'm_get_file_info.rb'
load 'm_find_fqfn.rb'

# TODO:  Build a model that contains the file types this system can recognize
#        and check existance of "myfile" file type in that list
Library.where("isleaf = true").find_each do |myfile|
  puts "-------------file: #{myfile.name}"
  next if /\.jpeg/.match(myfile.name) or /\.jpg/.match(myfile.name) #if the file type is ".jpeg" skip it and go on to the next record
  file_fqfn = m_find_fqfn(myfile)
  v_hash = m_get_file_info(file_fqfn) 
  myLFS = LibraryFileSpec.new(    :idoflibraryrecord => myfile.id, :filesizeinmb => v_hash[:file_size],
    :album => v_hash[:album],     :artist => v_hash[:artist], :comment => v_hash[:comment],  
    :genre => v_hash[:genre],     :title => v_hash[:title],   :track => v_hash[:track], 
    :year => v_hash[:year],       :length => v_hash[:length], :channels => v_hash[:channels],
    :bitrate => v_hash[:bitrate], :sample_rate => v_hash[:sample_rate])
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
