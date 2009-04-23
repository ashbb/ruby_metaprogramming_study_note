require 'creature'

class Turtle
  def initialize
    @x, @y = 250, 250
    @dirs = [[50, 0], [0, 50], [-50, 0], [0, -50]]
    @avatar = nil
    @pen = false
    @track = []
  end
  
  attr_accessor :avatar, :track
  
  def turtle_graphics &blk
    instance_eval &blk
  end
  
  def forward
    x, y = @dirs[0]
    @track << [@x += x, @y += y, @pen]
  end
  
  def back
    x, y = @dirs[0]
    @track << [@x -= x, @y -= y, @pen]
  end
  
  def right
    @dirs.push @dirs.shift
  end
  
  def left
    @dirs.unshift @dirs.pop
  end
  
  def pen_up
    @pen = false
  end
  
  def pen_down
    @pen = true
  end
end

Shoes.app :title => 'Turtle Graphics v0.1' do
  background moccasin, :margin=> 20, :curve => 20
  t = Turtle.new
  t.avatar = creature('loogink.png', 250, 250)
  
  t.turtle_graphics do
    pen_down
    1.upto 7 do |i|
      2.times{i.times{forward}; left}
    end
  end
  
  e = every 2 do
    x, y, pen = t.track.shift
    t.avatar.glide [x, y], :line => pen
    e.stop if t.track.empty?
  end
end