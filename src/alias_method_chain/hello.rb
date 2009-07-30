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