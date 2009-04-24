# turtle_graphics.rb
require 'creature'
require 'turtle'

Shoes.app :title => 'Turtle Graphics v0.2', :width => 660 do  
  def turtle_walk
    background forestgreen
    t = Turtle.new
  
    flow :width => 0.3 do
      button 'ok', :left => 5, :top => 2 do
        t.turtle_graphics @ed.text
        @run.call
      end
      button 'reset', :left => 58, :top => 2 do
        clear{turtle_walk}
      end
      @ed = edit_box :height => height - 30, :width => 180,
        :left => 5, :top => 30
    end
  
    flow :width => 0.7 do
      background white, :height => height - 25, :width => 450,
        :left => 0, :top => 10, :curve => 10
      paths = ['turtle3.png', 'turtle2.png', 'turtle1.png', 'turtle0.png']
      t.avatar = creature paths, 200, 250
      @run = proc do
        e = every 2 do
          x, y, pen = t.track.shift
          t.avatar.glide [x, y], :line => pen
          e.stop if t.track.empty?
        end
      end
    end
  end
  
  turtle_walk
end
