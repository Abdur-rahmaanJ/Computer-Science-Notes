##############
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2013


def weird(array1, out = [])
	array1.each {|ele1| out =  puts ele1 + "out" }
	out
end

p weird(["a","c","x"])

# [Mouseking6-3:~/desktop/RubyProgsMay31:10 copy/RubyWeek3-progs] markkean% !!
# ruby weird.rb
# aout
# cout
# xout
# nil
