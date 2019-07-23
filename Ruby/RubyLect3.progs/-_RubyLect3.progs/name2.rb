###########
# NAME2
## Copyright Mark Keane, All Rights Reserved, 2014

require_relative 'thanks'
require_relative 'error'  #comment out to see effects

def get_name 
	puts "What is your surname?:"
	name = gets.chomp 
	print_thanks 
	if check_name_ok?(name)
		then print_new_name(name) end
end

def check_name_ok?(nameo)
	if nameo.length > 10 
		then my_error("name too long")
	else true end
end

def print_new_name(namer)
	newname = namer + "babygi"
	puts "Your new name is:"
	puts newname
end

def print_thanks
	puts "Thanks for that."
end


get_name