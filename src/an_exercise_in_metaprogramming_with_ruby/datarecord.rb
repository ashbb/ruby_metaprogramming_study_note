# datarecord.rb
file = 'people.txt'
cname = File.basename(file,'.txt').capitalize
lines = IO.readlines file
attrs = lines.shift.chomp.split(',').collect{|attr| attr.to_sym}

klass = Object.const_set cname, Struct.new( *attrs )

data = []
lines.each do |line|
  values = eval "[#{line.chomp}]"
  data << klass.new( *values )
end

p data
