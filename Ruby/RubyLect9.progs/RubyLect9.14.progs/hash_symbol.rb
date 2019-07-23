class Big
   def initialize()
     @arr1 = Hash.new
   end
   
   def get_arr
   	 @arr1 
   end
   
   def update1
   	@arr1[:fi] = 1
   	@arr1[:fo] = 2
	p @arr1
   end
end


class Small
   def initialize()
     @arr2 = Hash.new
   end
   
   def get_arr1
   	 @arr2
   end
   
   def update2
   	@arr2[:fi] = 3
   	@arr2[:fum] = 4
	p @arr2
   end
   
end

a = Big.new; a.update1
b = Small.new; b.update2
p (a.get_arr).merge(b.get_arr1)