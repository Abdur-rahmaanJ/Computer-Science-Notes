
my_array = [:tom, "and", :joe, :are, :twins, "and", :so]

p my_array.each{|item|  [item] + ["blibb"]}

my_array.each{|item| p [item] + ["blibb"]}

p my_array.select{|item| item.is_a?(Symbol)}

p my_array.collect{|item| item.to_s[0..2]}

p my_array.map{|item| item.to_s[0..1]}

p my_array.inject{|a, b| [a, b]}