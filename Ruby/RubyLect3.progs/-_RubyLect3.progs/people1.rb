###########
# PEOPLE1
## Copyright Mark Keane, All Rights Reserved, 2013

class Person 
	attr_accessor :fname, :lname
end

inst1 = Person.new
inst1.fname = "mark"
inst1.lname = "keane"

inst2 = Person.new
inst2.fname = "mary"
inst2.lname = "dodds"

inst3 = Person.new
inst3.fname = "seth"
inst3.lname = "bladder"

p inst3
puts inst3
