4.times &b
left
3.times &f
pen_down
4.times &b
pen_up
2.times &f
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
2.times &f
2.times &r
pen_style
pen_down
4.times &f
pen_up
left
forward
left
4.times &f
right
pen_down
2.times &f
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
2.times &b
pen_up
left
4.times &b
left
forward
right
pen_style :stroke => 'deeppink', :strokewidth => 36
pen_down
3.times &f
pen_up
forward
left