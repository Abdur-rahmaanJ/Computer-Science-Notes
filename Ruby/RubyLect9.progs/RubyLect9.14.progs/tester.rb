=begin
class Tester
	
	def testa(a, b)
		a + b
	end
	
	def testa(a)
		a + 0
	end
	
end

abb = Tester.new

#p abb.testa(1, 2)
#p abb.testa(1)
#tester.rb:7:in `testa': wrong number of arguments (2 for 1) (ArgumentError)
#	from tester.rb:15:in `<main>'
	
p abb.testa(1)	
p abb.testa(1, 2)
#ruby tester.rb
#1
#tester.rb:7:in `testa': wrong number of arguments (2 for 1) (ArgumentError)
#	from tester.rb:21:in `<main>'
=end


class Tester
	def testa(a, b = 0)
		a + b
	end
end

abb = Tester.new
p abb.testa(1, 2)  # => 3
p abb.testa(1)     # => 1

=begin
class Tester
	def testa(*ab)
		if ab.size > 1
		 then ab[0] +  ab[1]
	    else ab[0]  + 0 end
	end
end

abb = Tester.new
p abb.testa(1, 2)  # => 3
p abb.testa(1)     # => 1
=end