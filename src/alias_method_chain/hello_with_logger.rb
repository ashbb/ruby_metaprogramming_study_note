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