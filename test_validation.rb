load './instance_counter.rb'
load './validation.rb'
load './company.rb'
load './station.rb'

st1 = nil

[
  '',
  '1234567890123456',
  [123],
  'Rostov-on-Don'
].each do |name|
  begin
    st1 = Station.new(name)

    puts "Name:#{name} is a valid name!"
    puts st1.inspect.to_s
  rescue RuntimeError => e
    puts "Try to create station with the name:#{name}"
    puts e
  end
end

puts

oldname = st1.name
st1.name = '9999999999999999999'
puts "Station #{oldname} renamed to #{st1.name}"
puts "Station is valid: #{st1.valid?}"

oldname = st1.name
st1.name = 'Moskva'
puts "Station #{oldname} renamed to #{st1.name}"
puts "Station is valid: #{st1.valid?}"
