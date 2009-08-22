Step3 input and output
----------------------

Input
-----

	html do
	  body do
	    content "Let's start!"
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
	    Let's start!
	    <form action='/page' method='post'>
	      <input type='text' maxlength='3' name='str' size='3'/>
	      <input type='submit' value='page'/>
	    </form>
	  </body>
	</html>


Note
----
Added white spaces and indentations for improving the readability.

