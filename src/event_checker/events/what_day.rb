title 'What day is it today?'

event 'Happy birthday, Satoshi!' do
  @today == '2.8'
end

event 'Happy birthday, Jane!' do
  @today == '14.9'
end

setup do
  @today = "%s.%s" % [Date.today.day, Date.today.month]
  @fortune = rand(5)
end

event 'Enjoy three-day weekend!' do
  %w[1.8 2.8 3.8].include? @today
end

event "Merry X'mas!" do
  @today == '25.12'
end

event "The fortune said that you'll have excellent luck!" do
  @fortune == 3
end
