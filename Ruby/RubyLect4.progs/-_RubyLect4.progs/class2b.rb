#!/usr/bin/ruby -w
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2010

class Visit
	attr_accessor :place, :person
	
	def initialize(pl, per)
		@place = pl
		@person = per
	end
	
	def print_visit
		puts "#{@person} visited #{@place}"
	end
	
	#def print_visit
	#	puts "#{@person.man_name} visited #{@place}"
	#end
	
end

 trip = Visit.new("venice", "mark")
# trip.print_visit
# will work if you use Trip