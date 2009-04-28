# turtle.rb
class Turtle
  def initialize
    @x, @y = 200, 250
    @dirs = [[50, 0], [0, 50], [-50, 0], [0, -50]]
    @eswn = [[0, 1], [2, 3], [4, 5], [6, 7]]
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
    @track << [@x += x, @y += y, @eswn[0], @pen]
  end
  
  def back
    x, y = @dirs[0]
    @track << [@x -= x, @y -= y, @eswn[0], @pen]
  end
  
  def right
    @dirs.push @dirs.shift
    @eswn.push @eswn.shift
    @track << [@x, @y, @eswn[0], :right]
  end
  
  def left
    @dirs.unshift @dirs.pop
    @eswn.unshift @eswn.pop
    @track << [@x, @y, @eswn[0], :left]
  end
  
  def pen_up
    @pen = false
  end
  
  def pen_down
    @pen = true
  end
  
  def method_missing m, *args
    @track << [m, args, nil, :others]
    m.to_s
  end
end
