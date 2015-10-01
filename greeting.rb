def greeting
  greet = ARGV.shift
  ARGV.each {|arg| puts "#{greet} #{arg}"}
#  ARGV.drop(1).each do {|arg| puts "#{ARGV.first} #{arg}"}
end

greeting
