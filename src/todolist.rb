# todolist.rb
module ToDoList
  def start
    @db ||= []
    show
  end

  def show
    @db.each_with_index{|list, n| print "#{n}: "; p list}
    puts '[-- nothing yet --]' if @db.empty?
    nil
  end
  
  def add todo, args = {}
    list = []
    args[:todo] = todo
    @db << args
    nil
  end
  
  def cmd
    p ToDoList.instance_methods
    nil
  end
  
  def method_missing m, *args
    if /^sort_by_/ =~ m.to_s
      ToDoList.class_eval do
        define_method m do
          @db = @db.sort_by{|h| h[m.to_s.split('_').last.to_sym].to_s}
          nil
        end
      end
    else
      puts "Sorry, not support #{m} command." 
    end
    nil
  end
  
  def delete n
    @db.delete_at n
    nil
  end
  
  def self.method_added m
    Main.send m
    nil
  end
end

Main = self
extend ToDoList
start
