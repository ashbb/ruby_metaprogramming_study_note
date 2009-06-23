# human_walking
require 'swing'
DENIES = %w[@body @base_t @f @t]

positions = IO.readlines 'hw.data'

class Node
  include Swing
  
  def initialize body, arg = {}
    arg.each{|k, v| instance_variable_set "@#{k}", v}
    @r ||= 0;  @rl ||= 5; @rs ||= 10; @theta ||= -0.5;  @t ||= 90;  @speed ||= 5
    @x ||= 0; @y ||= 0
    @body, @base_t, @f = body, @t, true
  end
end

Shoes.app :width => 300, :height => 600, :title => 'Human Walking v0.1' do
  nodes, @stop, @flag = [], false, false
  nostroke
  fill white
  background black
  
  positions.each{|pos| nodes << Node.new(oval(0, 0, 5).hide, eval(pos))}
  
  button('off/on', :left => 10, :top => 10){@stop = !@stop}
  button 'save', :left => 100, :top => 10 do
    open 'hw.data', 'w' do |f|
      nodes.each do |node|
        a = node.instance_variables.delete_if{|v| DENIES.include? v}.collect do |v|
          "#{v.sub('@', ':')} => #{node.instance_eval v}"
        end.join(', ')
        f.puts "{#{a}}"
      end
    end
  end
  
  a = animate 36 do |i|
    ([:ellipse_half] * 9 + [:ellipse] * 6).each_with_index do |m, i|
      nodes[i].body.move *(nodes[i].send m)
      nodes[i].body.show
    end unless @stop
  end
  
  nodes.each do |node|
    node.body.click{@flag = true; @node = node}
    node.body.release{@flag = false}
    motion do |left, top|
      begin
        @node.body.move(left - 1, top - 1)
        @node.x, @node.y = left, top
      end if @flag
    end
  end
end
