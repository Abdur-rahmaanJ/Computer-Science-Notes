###########
# TIMES
## Copyright Mark Keane, All Rights Reserved, 2013

def five_it(item)
   5.times do |count|
      p item + count.to_s
    end
end

def print_several(no, item)
  no.times {p item}
end


five_it("boo")
puts
print_several(10, "gpp")



