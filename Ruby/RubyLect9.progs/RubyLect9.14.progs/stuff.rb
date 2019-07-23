

def add_numbers(*nos)
	p nos
	nos.reduce(:+)
end


def arith(fn, *nos)
	p [fn] + nos
	nos.reduce(fn)
end

p add_numbers(1)
p add_numbers(1,3,5,7)
p add_numbers(1, 4)

p arith(:+, 1, 4, 5, 6)
p arith(:*, 1, 4, 5, 6)

