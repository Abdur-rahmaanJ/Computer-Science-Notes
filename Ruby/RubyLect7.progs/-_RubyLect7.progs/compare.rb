# UPDATED FOR CATEGORIES
# Copyright Mark Keane, All Rights Reserved, 2013

def ascii(stringy)
	stringy.each_byte {|c| puts c}
end

str_a = "foobar"
str_b = "foobas"

ascii(str_a)
puts "\n"
ascii(str_b)
puts "\n"

p str_a == str_a
p str_a == str_b

p str_a < str_b
p str_a > str_b
p str_b < str_a

p str_a <=> str_b
p str_a <=> str_a
p str_b <=> str_a