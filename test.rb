Dir.foreach(".") do |x|
  puts "Entry #{x}"
  if Dir.exists?(x)
    puts "  Directory"
  elsif File.exists?(x)
    puts "  File"
  else
    puts "  Unknown"
  end
end


