# ashbb-csv-2.rb
class DataRecord
  def self.make file
    cname = File.basename(file,'.txt').capitalize
    line = ''
    open(file, 'r'){|f| line = f.gets.chomp}
    attrs = line.split(',').collect{|attr| attr.to_sym}
    klass = Object.const_set cname, Struct.new( *attrs )
    
    def klass.read
      IO.readlines(self.to_s.downcase + '.txt')[1..-1].collect do |line|
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
