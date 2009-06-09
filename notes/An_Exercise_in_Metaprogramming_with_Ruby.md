An Exercise in Metaprogramming with Ruby
----------------------------------------

**Hal Fulton**'s fantastic exercise!

- [An Exercise in Metaprogramming with Ruby](http://www.devsource.com/c/a/Languages/An-Exercise-in-Metaprogramming-with-Ruby/) (English)
- [An Exercise in Metaprogramming with Ruby](http://yohasebe.com/files/translation/aEiMwR/index.html) (Japanese)

Input data files:
-----------------

	file: people.txt
	
	name,age,weight,height
	"Smith, John", 35, 175, "5'10"
	"Ford, Anne", 49, 142, "5'4"
	"Taylor, Burt", 55, 173, "5'10"
	"Zubrin, Candace", 23, 133, "5'6"

	file: place.txt
	
	latitude,longitude,description
	47.23,59.34,'Omaha'
	32.17,39.24,'New York City'
	73.11,48.91,'Carlsbad Caverns'

Outputs:
--------

	>ruby ashbb-csv-2.rb
	
	[#<struct People name="Smith, John", age=35, weight=175, height="5'10">, 
	#<struct People name="Ford, Anne", age=49, weight=142, height="5'4">, 
	#<struct People name="Taylor, Burt", age=55, weight=173, height="5'10">, 
	#<struct People name="Zubrin, Candace", age=23, weight=133, height="5'6">]
	
	[#<struct People name="Smith, John", age=35, weight=175, height="5'10">, 
	#<struct People name="Ford, Anne", age=49, weight=142, height="5'4">, 
	#<struct People name="Taylor, Burt", age=55, weight=173, height="5'10">, 
	#<struct People name="Zubrin, Candace", age=23, weight=133, height="5'6">]

	[#<struct Place latitude=47.23, longitude=59.34, description="Omaha">, 
	#<struct Place latitude=32.17, longitude=39.24, description="New York City">, 
	#<struct Place latitude=73.11, longitude=48.91, description="Carlsbad Caverns">]
	
	[#<struct Place latitude=47.23, longitude=59.34, description="Omaha">, 
	#<struct Place latitude=32.17, longitude=39.24, description="New York City">, 
	#<struct Place latitude=73.11, longitude=48.91, description="Carlsbad Caverns">]
	
	>Exit code: 0

**Note:**  Inserted new lines by hand for fuman readablity.


Original code:
--------------

	#my-csv.rb
	class DataRecord
	
	  def self.make(file_name)
	    data = File.new(file_name)
	    header = data.gets.chomp
	    data.close
	    class_name = File.basename(file_name,".txt").capitalize  
	    # "foo.txt" => "Foo"
	    klass = Object.const_set(class_name,Class.new)
	    names = header.split(",")
	
	    klass.class_eval do
	      attr_accessor *names
	
	      define_method(:initialize) do |*values| 
	        names.each_with_index do |name,i| 
	          instance_variable_set("@"+name, values[i])
	        end
	      end
	
	      define_method(:to_s) do
	        str = "<#{self.class}:"
	        names.each {|name| str << " #{name}=#{self.send(name)}" }
	        str + ">"
	      end
	      alias_method :inspect, :to_s
	    end
	
	    def klass.read
	      array = []
	      data = File.new(self.to_s.downcase+".txt")
	      data.gets
	      data.each do |line| 
	        line.chomp!   
	        values = eval("[#{line}]")
	        array << self.new(*values)
	      end
	      data.close
	      array
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
	


Static coding:
------------
If we can know the data structure in advance and it's not changed in the future, we can write the code statically like this.

	# peoples.rb
	People = Struct.new :name, :age, :weight, :height
	peoples = []
	IO.readlines('people.txt')[1..-1].each do |line|
	  values = eval "[#{line.chomp}]"
	  peoples << People.new( *values )
	end
	p peoples


Dynamic coding:
---------------
Struct.new is useful. That's not an exercise for metaprogramming, though. :-P

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


As a library 1:
---------------
Define class DataRecord which reads attributes and values at once from the data file.

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


As a library 2:
---------------
Define class DataRecord which reads attributes and values separately from the data file.

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
