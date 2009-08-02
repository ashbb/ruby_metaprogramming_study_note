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
