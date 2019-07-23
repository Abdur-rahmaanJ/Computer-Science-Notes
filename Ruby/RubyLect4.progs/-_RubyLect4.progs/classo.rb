##############
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2010

class Testo
	attr_accessor :name, :surname
	
	def initialize(name, surn)
		@name = name
		@surname = surn
	end
	
	def print_name 
		puts "#{@name}, #{@surname}"
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
mark.man_name = ["mr", "mark", "bean"]
p mark.man_name
mark.print_name

