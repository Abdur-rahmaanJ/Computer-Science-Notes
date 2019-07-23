##############
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2013

require_relative 'class2b'

class Testo
	attr_accessor :name, :surname
	
	def initialize(name, surn)
		@name = name
		@surname = surn
	end
		
	def man_name
		"mr " + @name + @surname
	end
	
	def man_name=(name_array)
		@name = name_array[1]
		@surname = name_array[2]
	end
end

mark = Testo.new("mark", "keane")
p mark.man_name
p mark
trip = Visit.new("venice", mark)
trip.print_visit

# p trip  # does not work if called within here after being set up in class2b 

