Event Checker
-------------
Original code is **Red Flag** which is presented in Metaprogramming Ruby, Chapter 3. **Event Chekcer** is a slightly-altered code.


DSLs
----

project_a.rb

	# project_a.rb
	
	event 'Do troubleshooting as the top priority!' do
	  @claims > 9
	end
	
	event 'Bug fix first!' do
	  @bugs > @claims
	end
	
	setup do
	  @bugs = 10
	  @claims = 15
	end
	
	title "Checking: #{File.basename(__FILE__)[0...-3]} ..."

project_b.rb

	# project_b.rb
	
	setup do
	  @requests = 10
	end
	
	title "Checking: #{File.basename(__FILE__)[0...-3]} ..."
	
	event 'Do updating your ToDoList!' do
	  @requests > 9
	end

what_day.rb

	# what_day.rb
	
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


Execute event_cheker.rb
-----------------------
	# event_checker.rb
	
	def title msg
	  @title = "\n"
	  @title << msg << "\n" << ('-'* msg.length)
	end
	
	def event msg, &blk
	  @events[msg] = blk
	end
	
	def setup &blk
	  @setups << blk
	end
	
	Dir.glob("events/*.rb").each do |file|
	  @events, @setups = {}, []
	  load file
	  puts @title
	  @events.each do |msg, event|
	    obj = Object.new
	    @setups.each do |setup|
	      obj.instance_eval &setup
	    end
	    puts msg if obj.instance_eval &event
	  end
	end


Output
------

	>ruby event_checker.rb
	Checking: project_a ...
	-----------------------
	Do troubleshooting as the top priority!
	
	Checking: project_b ...
	-----------------------
	Do updating your ToDoList!
	
	What day is it today?
	---------------------
	The fortune said that you'll have excellent luck!
	Enjoy three-day weekend!
	Happy birthday, Satoshi!
	>Exit code: 0

