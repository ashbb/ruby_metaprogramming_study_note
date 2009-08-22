XML generator
-------------

Follow these steps to create a tiny XML generator: <b>xml.rb</b>

We can use it like this:

- Look at [sample_html.rb](./XML_generator/sample_html.md)
- Need to write <b>XML</b> class with <b>xml_generate()</b> method.
- Line 9-22 is our tiny DSL code to create the output (xml format text). It'll be stored to <b>sample_twitters.html</b> file at the last line.
- Line 4-6 is the input data, just a sample for this practice.
- Look at the output: [sample_twitters.html](./XML_generator/sample_twitters_html.md) and a [screenshot](./XML_generator/sample_screenshot.png).

<br>
Step 1
------
Let's start!   
Create two files: <b>sample_html.rb</b> and <b>xml.rb</b>

<b>sample_html.rb</b> has the following features.

- create a XML object
- call <b>xml_generate()</b> method
- at first, the input is only one line: <b>content "Let's start!"</b>
- store the output (created xml)

<br>

<b>xml.rb</b> has the following three instance methods.

- initialize
- content
- xml_generate

<br>

<b>Hint:</b> instance_eval

<br>

Look at the [input and output](./XML_generator/XML_Step1.md) for Step 1.

<br>
Step 2
------
Improve to accept the following inputs.

	html do
	  body do
	    content "Let's start!"
	  end
	end

<br>

<b>Hint:</b> method_missing

<br>

Look at the [input and output](./XML_generator/XML_Step2.md) for Step 2.

<br>
Step 3
------
Improve to accept the following inputs.

	html do
	  body do
	    content "Let's start!"
	    form :action => '/page', :method => 'post' do
	      input :type => 'text', :name => 'str', :maxlength => 3, :size => 3
	      input :type => 'submit', :value => 'page'
	    end
	  end
	end

<br>

<b>Hint:</b> hash

<br>

Look at the [input and output](./XML_generator/XML_Step3.md) for Step 3.

<br>
Step 4
------
Improve to accept the following inputs.   
Use [this pic](./XML_generator/b-satoshi.jpg) as a avatar.

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

<br>

<b>Hint:</b> no need to use any more metaprogramming tech.

<br>

Look at the [input and output](./XML_generator/XML_Step4.md) for Step 4.

<br>
Step 5
------
We want to replace <b>XML.new.xml_generate</b> to <b>XML.generate</b>.

<br>

<b>Hint:</b> define class method

<br>

<b>Let's discuss your code in the relevant thread in the Second Week Forum.</b>

<br>