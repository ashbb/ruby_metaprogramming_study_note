# event_checker.rb

def title msg
  @title = "\n"
  @title << msg << "\n" << ('-'* msg.length)
end

def event msg, &blk
  @events[msg] = blk
end

def setup &blk
  @setups << blk
end

Dir.glob("events/*.rb").each do |file|
  @events, @setups = {}, []
  load file
  puts @title
  @events.each do |msg, event|
    obj = Object.new
    @setups.each do |setup|
      obj.instance_eval &setup
    end
    puts msg if obj.instance_eval &event
  end
end
