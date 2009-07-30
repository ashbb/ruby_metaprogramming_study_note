alias\_method\_chain
------------------
Rails provides a generic aliasing method `alias_method_chain` as the `ActiveSupport` library.

	# aliasing.rb
	
	module ActiveSupport
	  module Module
	    def alias_method_chain(target, feature)
	      aliased_target, punctuation = target.to_s.sub(/([?!=])$/, '' ), $1
	      yield(aliased_target, punctuation) if block_given?
	      with_method = "#{aliased_target}_with_#{feature}#{punctuation}"
	      without_method ="#{aliased_target}_without_#{feature}#{punctuation}"
	      alias_method without_method, target
	      alias_method target, with_method
	      case
	        when public_method_defined?(without_method)
	          public target
	        when protected_method_defined?(without_method)
	          protected target
	        when private_method_defined?(without_method)
	          private target
	      end
	    end
	  end
	end
	

To understand how it is useful, look at the following example:

	# hello.rb
	class Hello
	  def hello
	    puts 'hello'
	  end
	end
	
	if __FILE__ == $0
	  say = Hello.new
	  say.hello
	end

Output is:

	hello


Now suppose you want to wrap logging behavior around `Hello#hello()`.
You can use `ActiveSupport::Module::alias_method_chain()`.

	# hello_with_logger.rb
	require 'hello'
	require 'aliasing'
	
	class Hello
	  extend ActiveSupport::Module
	  
	  def hello_with_logger
	    puts '--logging start'
	    hello_without_logger
	    puts "--logging end\n\n"
	  end
	  
	  alias_method_chain :hello, :logger
	end
	
	say = Hello.new
	say.hello
	say.hello_with_logger
	say.hello_without_logger


Output is:

	--logging start
	hello
	--logging end
	
	--logging start
	hello
	--logging end
	
	hello


