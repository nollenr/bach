ext_hash = Hash.new
Library.where("isleaf = true").find_each do |myfile|
  puts   "-------------file: #{myfile.name}"
  if m = /.*(?<extension>\..+$)/.match(myfile.name)
    # puts "             Matchdata: #{m[:extension]}"
    ext_hash.has_key?(m[:extension]) ? ext_hash[m[:extension]] += 1 : ext_hash[m[:extension]] = 1
  else
    puts "             no extension found"
  end
end

=begin
  I now have a hash of all the extensions found in my library, I'm going to add those
  extensions to the model "FileExtension".  
=end 

ext_hash.each_key{|key|
  num_recs = FileExtension.select("count(*)").find_by(:extension =>  key).count
  if num_recs == 0
    FileExtension.create(:extension => key)
  end
}

