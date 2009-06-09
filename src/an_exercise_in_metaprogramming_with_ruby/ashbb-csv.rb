# ashbb-csv.rb
class DataRecord
  def self.make file
    cname = File.basename(file,'.txt').capitalize 
    @@lines = IO.readlines file
    attrs = @@lines.shift.chomp.split(',').collect{|attr| attr.to_sym}
    klass = Object.const_set cname, Struct.new( *attrs )
    
    def klass.read
      @@lines.collect do |line|
        values = eval "[#{line.chomp}]"
        self.new( *values )
      end
    end
    
    klass
  end
end

data = DataRecord.make 'people.txt'
p data.read
p People.read

data = DataRecord.make 'place.txt'
p data.read
p Place.read
