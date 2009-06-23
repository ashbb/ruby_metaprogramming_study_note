module Swing
  N = 360
  attr_reader :body
  attr_accessor :x, :y
  
  def circle
    @rl = @rs = @r
    ellipse
  end
  
  def ellipse
    x, y = rotate *position
    [@x + x.to_i, @y + y.to_i]
  end
    
  def position
    angle = 2 * Math::PI * @t / N - Math::PI / 2
    @t += @speed
    [@rl * Math.cos(angle), @rs * Math.sin(angle)]
  end
    
  def rotate x, y
    [x * Math.cos(@theta) + y * Math.sin(@theta), -x * Math.sin(@theta) + y * Math.cos(@theta)]
  end
  
  def reverse
    @speed = -@speed
  end
  
  def ellipse_half
    x, y = ellipse
    reverse if @t % 360 == (@base_t + 180) % 360 or @t % 360 == @base_t % 360
    [x, y]
  end
  
  def infinite
    x, y = ellipse
    if @f 
      begin
        @x, @y = @x - @rl * Math.cos(@theta) * 2, @y + @rl * Math.sin(@theta) * 2
        @f = !@f
        reverse
        @t = 90
      end if @t % 360 == 270
    else
      begin
        @x, @y = @x + @rl * Math.cos(@theta) * 2, @y - @rl * Math.sin(@theta) * 2
        @f = !@f
        reverse
        @t = 270
      end if @t % 360 == 90
    end
    @x, @y = @x.to_i, @y.to_i
    [x, y]
  end
end
