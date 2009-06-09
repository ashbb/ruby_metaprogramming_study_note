# peoples.rb
People = Struct.new :name, :age, :weight, :height
peoples = []
IO.readlines('people.txt')[1..-1].each do |line|
  values = eval "[#{line.chomp}]"
  peoples << People.new( *values )
end
p peoples