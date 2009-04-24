# turtle.rb
class Turtle
  def initialize
    @x, @y = 200, 250
    @dirs = [[50, 0], [0, 50], [-50, 0], [0, -50]]
    @avatar = nil
    @pen = false
    @track = []
  end
  
  attr_accessor :avatar, :track
  
  def turtle_graphics str
    instance_eval str
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
