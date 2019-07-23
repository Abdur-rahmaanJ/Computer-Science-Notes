

foo = Hash.new

foo[:a] = 1
foo[:b] = 2
foo[:c] = 3


p foo

p foo[:c]

foo[:c] = "hi"

p foo

p foo[:a] + foo[:b] + foo[:b]

p foo.keys

p foo.values

