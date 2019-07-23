###########
# PEOPLE3
## Copyright Mark Keane, All Rights Reserved, 2014

class Person 
   attr_accessor :fname, :lname, :age
   def initialize(fname, lname)
     @fname = fname
     @lname = lname
   end
   
   def to_s
     "hi " + @fname + ", " + @lname
   end
   
   def self.make_person(fnme, lnme, age)
   	 new_person = Person.new(fnme, lnme)
   	 new_person.age = age
   	 new_person
   end
   
   def age_person
	   @age = @age + 1
   end
   
#   def age_person
#   	 self.age = self.age + 1
#      self
#   end
end

mk =  Person.make_person("mark","keane", 55)
p mk
puts mk
p mk.age_person
#p mk.age
#p mk.age_person