
=begin
begin

# Any number of ruby statements here
# Usually, they are executed without exceptions and
# execution continues after the end statement

rescue

# This is the rescue clause; exception-handling code goes here
# If an exception is raised by the code above, or propagates up
# from one of the methods called above, then the excecution jumps here

end
=end

puts "BAD PLUS TEST*******"
def bad_plus(x, y)
  begin
	sum = x + y
  rescue
    puts "Errors is:"
    p $!				#could also use $ERROR_INFO with require 'English'
	puts "Have Fixed Crappy Args"
	sum = x + y[0]
  end
  puts "Sum is: #{sum}"
end


bad_plus(3, 4)
bad_plus(3,[5, 6, 7])

puts "BAD PLUS EXTRA TEST*******"
def bad_plus_extra(x, y)
  begin
	sum = x + y
  rescue => exceptcase
    p exceptcase
	puts "Have Fixed Crappy Args"
	sum = x + y[1]
  end
  puts "Sum is: #{sum}"
  p exceptcase
end

bad_plus_extra(3, 4)
bad_plus_extra(3,[5, 6, 7])


puts "BAD SUM TEST*******"
def bad_sum(x, y, z)
  begin
	if z == 0 then mysum(x, y) else mysum(x,y,z) end
  rescue TypeError => exceptcase
	puts "Crappy type detected: #{exceptcase}"
  rescue ArgumentError => exceptcase
	puts "Crappy args detected: #{exceptcase}"
  end
end

def mysum(x, y, z); p (x + (y + z)) end

bad_sum(2, 3, 4)
bad_sum(2, 3, 0)
bad_sum(2, 3, [4])