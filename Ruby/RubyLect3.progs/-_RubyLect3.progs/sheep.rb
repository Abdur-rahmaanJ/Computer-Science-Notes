###########
# SHEEP
## Copyright Mark Keane, All Rights Reserved, 2010

listy =["a_", "b_", "c_"]

def sheepify(an_array)
   an_array.each {|item| p item + "sheep"}
end

p sheepify(listy)

