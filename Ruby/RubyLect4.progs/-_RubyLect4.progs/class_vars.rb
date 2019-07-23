##############
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2010

class Visit
	@@all = []
	Places = ["berne","venice"]
	attr_accessor :place, :person
	def initialize(pl, per)
		@place = pl
		@person = per
	end
	
	def to_s
		puts "#{@person} visited #{@place}"
	end
	
	def all
		@@all
	end
	
	def self.all
		@@all
	end
	
	def add_visit_via_instance
	   @@all << self
	end
	
	def self.add_visit_via_class=(inst)
		@@all << inst
	end

end


foo = Visit.new("venice", "ruth_b")
bar = Visit.new("berne", "mark_k")
puts foo
puts bar
puts "Value of @@all, found via foo, is now:"
p foo.all
foo.add_visit_via_instance
puts "value of @@all, found via bar, is now"
p bar.all
Visit.add_visit_via_class = bar
puts "value of @@all, found via the class, is now:"
p Visit.all
p Visit::Places

# [Mouseking6-3:~/desktop/RubyProgsMay31:10 copy/RubyWeek3-progs] markkean% !!
# ruby class_vars.rb
# ruth_b visited venice
# #<Visit:0x271a0>
# mark_k visited berne
# #<Visit:0x27164>
# Value of @@all, found via foo, is now:
# []
# value of @@all, found via bar, is now
# [#<Visit:0x271a0 @person="ruth_b", @place="venice">]
# value of @@all, found via the class, is now:
# [#<Visit:0x271a0 @person="ruth_b", @place="venice">, #<Visit:0x27164 @person="mark_k", @place="berne">]
# ["berne", "venice"]

