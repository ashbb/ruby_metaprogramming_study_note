Step4 input and output
----------------------

Input
-----

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

Output
------

	<html>
	  <body>
	    <img width='25' height='25' src='./b-satoshi.jpg' alt='Satoshi'/>
	     : hello world!
	    <br/>
	    <br/>
	    <img width='25' height='25' src='./b-satoshi.jpg' alt='Satoshi'/>
	     : hello world!
	    <br/>
	    <br/>
	    <img width='25' height='25' src='./b-satoshi.jpg' alt='Satoshi'/>
	     : hello world!
	    <br/>
	    <br/>
	    <img width='25' height='25' src='./b-satoshi.jpg' alt='Satoshi'/>
	     : hello world!
	    <br/>
	    <br/>
	    <img width='25' height='25' src='./b-satoshi.jpg' alt='Satoshi'/>
	     : hello world!
	    <br/>
	    <br/>
	    <form method='post' action='/page'>
	      <input type='text' maxlength='3' name='str' size='3'/>
	      <input type='submit' value='page'/>
	    </form>
	  </body>
	</html>


Note
----
Added white spaces and indentations for improving the readability.

