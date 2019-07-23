###########
# DEFBLOCK
## Copyright Mark Keane, All Rights Reserved, 2013

def add_two(no)
	no += 2
end

p add_two(5)

def add_two_b
	yield(10)
end

p add_two_b {|no| no + 2}