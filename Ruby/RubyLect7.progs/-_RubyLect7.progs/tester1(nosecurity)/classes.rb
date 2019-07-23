class Topper
	include Tester
	
	def do_it()
		puts "do it"
	end
end


class Bottomer < Topper
	def bottomer
	    puts "bottomer"
	end
end

