###########
# # PEOPLE1a*
## Copyright Mark Keane, All Rights Reserved, 2016

class Person
   attr_accessor :name1, :name2
   def initialize(fname, lname)
     @fname = fname
     @lname = lname
   end

end

inst1 = Person.new("mark","keane")

p    inst1

inst1.name1 = 'blibbidy'

p    inst1

