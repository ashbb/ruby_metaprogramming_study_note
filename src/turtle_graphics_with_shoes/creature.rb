# creature.rb
class Shoes::Creature < Shoes::Widget
  def initialize paths, x, y, eswn
    @paths = paths
    rewrite x, y, eswn
    @imgs.first.show
    @moving = false
  end
  
  def glide args, eswn, opt = {:line => false}
    args << @imgs.first.left << @imgs.first.top
    x1, y1, x0, y0 = args.collect{|e| e.to_f}
    
    @moving = true
    a = animate(48) do |i|
      case
        when x0 < x1
          x = x0 + i
          y = y0 + (y1 - y0) / (x1 - x0) * i  if y0 < y1
          y = y0  if y0 == y1
          y = y0 - (y0 - y1) / (x1 - x0) * i  if y0 > y1
          max = x1 - x0
        when x0 == x1
          x = x0
          y = y0 + i  if y0 < y1
          y = y0 - i  if y0 > y1
          y = y0  if y0 == y1
          max = (y1 - y0).abs
        when x0 > x1
          x = x0 - i
          y = y0 + (y1 - y0) / (x0 - x1) * i  if y0 < y1
          y = y0  if y0 == y1
          y = y0 - (y0 - y1) / (x0 - x1) * i  if y0 > y1
          max = x0 - x1
        else
      end
        
      @l.remove if @l
      strokewidth 6
      @l = line(x0 + 15, y0 + 15, x.to_i + 15, y.to_i + 15, :stroke => thistle)  if opt[:line]
      rewrite x.to_i, y.to_i, eswn
      @imgs[(i / 12) % 2].show
      
      if i == max
        a.stop
        @moving = false
        line(x0 + 15, y0 + 15, x.to_i + 15, y.to_i + 15, :stroke => peru)  if opt[:line]
        rewrite x.to_i, y.to_i, eswn
        @imgs[(i / 12) % 2].show
      end
    end
  end
  
  def rewrite x, y, eswn
    @imgs.each{|img| img.remove} if @imgs
    @imgs = []
    
    eswn.map{|n| @paths[n]}.each do |path|
      @imgs.unshift image(path, :left => x, :top => y).hide
    end
  end
  
  def rotate x, y, n
    @imgs.each{|img| img.remove} if @imgs
    @imgs = [image(@paths[n], :left => x, :top => y)]
  end
  
  def moving?
    @moving
  end
end
