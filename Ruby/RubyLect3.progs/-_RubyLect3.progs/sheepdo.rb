###########
# SHEEPDO
## Copyright Mark Keane, All Rights Reserved, 2010


listy =["a_", "b_", "c_"]

def sheepify_with_do(an_array)
	an_array.each do |item|
   			new_sheep = item + "sheep"
   			uniq_no = new_sheep.object_id
 			puts "#{new_sheep} is no #{uniq_no}"
	end
end

sheepify_with_do(listy)








