4.times{back}
left
3.times{forward}
pen_down
4.times{back}
pen_up
2.times{forward}
right
pen_style :stroke => 'green', :strokewidth => 3
pen_down
forward
pen_style :stroke => 'red'
forward
pen_style :stroke => 'yellow'
forward
pen_up
left
2.times{forward}
2.times{right}
pen_style
pen_down
4.times{forward}
pen_up
left
forward
left
4.times{forward}
right
pen_down
2.times{forward}
pen_up
back
right
pen_down
[['gold', 3], ['lime', 6], ['orangered', 3], ['navy', 6]].each do |color, w|
  pen_style :stroke => color, :strokewidth => w
  forward
end
right
pen_up
forward
pen_style
pen_down
2.times{back}
pen_up
left
4.times{back}
left
forward
right
pen_style :stroke => 'deeppink', :strokewidth => 36
pen_down
3.times{forward}
pen_up
forward
left