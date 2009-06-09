# mkmd.rb

def read_src name, file
  dir = File.basename file, '.md'
  IO.readlines("../src/#{dir.downcase}/" + name).collect{|c| "\t" + c}
end


Dir.glob("../notes/*.md").each do |file|
  lines = IO.readlines file
  open(file, 'w') do |f|
    lines.each do |line|
      new_line = line
      line.sub(/^# *(.*\.rb)/){new_line = read_src $1, file}
      #line.sub(/^# *(.*\.(png|jpg|gif))/){new_line = make_link($1)}
      f.puts new_line
    end
  end
end
