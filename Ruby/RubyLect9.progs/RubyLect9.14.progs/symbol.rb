class Big
   def initialize()
     @arr1 = [:fi, :fie, :foe]
   end
   
   def get_arr
   	 @arr1
   end

end


class Small
   def initialize()
     @arr2 = [:fi, :fie1, :foe]
   end
   
   def get_arr1
   	 @arr2
   end
   
end

a = Big.new
b = Small.new

p a.get_arr
p b.get_arr1

p (a.get_arr)[0] == (b.get_arr1)[0]
p (a.get_arr)[1] == (b.get_arr1)[1]
p (a.get_arr)[2] == (b.get_arr1)[2]
