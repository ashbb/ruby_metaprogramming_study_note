sample_html.rb
--------------

	# sample_html.rb
	require 'xml'
	
	Twitter = Struct.new :name, :avatar, :text
	twitters = []
	5.times{twitters << Twitter.new('Satoshi', './b-satoshi.jpg', 'hello world!')}
	
	xml = XML.new.xml_generate do
	  html do
	    body do
	      twitters.each do |tw|
	        img :src => tw.avatar, :alt => tw.name, :width => 25, :height => 25
	        content [" : " , tw.text]
	        br
	        br
	      end
	      form :action => '/page', :method => 'post' do
	        input :type => 'text', :name => 'str', :maxlength => 3, :size => 3
	        input :type => 'submit', :value => 'page'
	      end
	    end
	  end
	end
	
	open('sample_twitters.html', 'w'){|f| f.puts xml}
