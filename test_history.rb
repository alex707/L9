load './instance_counter.rb'
load './accessors.rb'
load './validation.rb'
load './company.rb'
load './train.rb'

t1 = Train.new('123456', 'pass')

## strong type
puts "Train number before:#{t1.number}"
badnum = 123
begin
  t1.number = badnum
rescue RuntimeError => e
  puts "Try to save invalid number:#{badnum}"
  puts e
end
puts "Train number after:#{t1.number}"

## history
puts
puts "Train's speed history before: #{t1.speed_history}"
t1.speed = 1
t1.speed = 2
t1.speed = 3
puts "Train's speed history after: #{t1.speed_history}"
