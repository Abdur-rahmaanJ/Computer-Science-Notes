###########
# OLDIE1
## Copyright Mark Keane, All Rights Reserved, 2014


class Male
  attr_accessor :name, :age
  def initialize(nme, age)
    @name = nme
    @age = age
  end

  def is_he_old?
    age_of_pers = @age
    if age_of_pers > 21
       then puts "yea, an oldie"
       	    true
    elsif age_of_pers == 21
       then puts "middle_aged..."
       		false
    else puts "just a child !"
   			false
    end
  end
end


marko = Male.new("marko", 53)
marko.is_he_old?
p marko.is_he_old?