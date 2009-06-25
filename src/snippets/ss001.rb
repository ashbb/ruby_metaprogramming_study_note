# ss001.rb
class Dog
  def say
    def cry
      def bark
        puts 'Wooo!'
      end
    end
  end
end

d = Dog.new
p Dog.instance_methods(false)  #=> ["say"]
d.say
p Dog.instance_methods(false)  #=> ["say", "cry"]
d.cry
p Dog.instance_methods(false)  #=> ["say", "bark", "cry"]
d.bark  #=> Wooo!