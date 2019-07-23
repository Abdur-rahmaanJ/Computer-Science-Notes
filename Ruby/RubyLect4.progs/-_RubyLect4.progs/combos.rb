##############
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2013

def combos(array1, array2, n = 0)
	array1.each do |ele1|
		array2.each do |ele2|
			n += 1
			puts "#{ele1}, #{ele2}, on #{n}"
		end
	end
end

combos(["a", "b","c"], [1,2,3])

# [Mouseking6-3:~/desktop/RubyProgsMay31:10 copy/RubyWeek3-progs] markkean% !!
# ruby combos.rb
# a, 1, on 1
# a, 2, on 2
# a, 3, on 3
# b, 1, on 4
# b, 2, on 5
# b, 3, on 6
# c, 1, on 7
# c, 2, on 8
# c, 3, on 9



