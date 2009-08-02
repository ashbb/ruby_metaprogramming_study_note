setup do
  @requests = 10
end

title "Checking: #{File.basename(__FILE__)[0...-3]} ..."

event 'Do updating your ToDoList!' do
  @requests > 9
end
