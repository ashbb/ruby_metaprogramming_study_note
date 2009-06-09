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

data = DataRecord.make 'place.txt'
p data.read
p Place.read
