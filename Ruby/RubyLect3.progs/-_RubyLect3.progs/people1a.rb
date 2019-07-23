###########
# # PEOPLE1a
## Copyright Mark Keane, All Rights Reserved, 2016

class Person 
   attr_accessor :fname, :lname
   def initialize(fname, lname)
     @fname = fname
     @lname = lname
   end
   
end

inst1 = Person.new("mark","keane")
inst2 = Person.new("mary","dodds")
inst3 = Person.new("seth","bladder")

p    inst1

