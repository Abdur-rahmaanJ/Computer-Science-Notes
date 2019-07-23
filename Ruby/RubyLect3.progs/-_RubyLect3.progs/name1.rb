###########
# NAME1
## Copyright Mark Keane, All Rights Reserved, 2013

def get_name 
	puts "What is your surname?:"
	name = gets 
	#name =  gets.chomp  #remove the /n
	print_thanks 
	if check_name_ok?(name)
		then print_new_name(name) end
end

def print_thanks
	puts "Thanks for that."
end

def check_name_ok?(nameo)
	if nameo.length > 10 
		then error("way too long a name")
	else true end
end

def print_new_name(namer)
	newname = namer + "babygi"
	puts "Your new name is:"
	#p newname
	puts newname
end


def error(sp_message)
	puts "\n**ERROR** Problem with #{sp_message}.\n"
end


get_name