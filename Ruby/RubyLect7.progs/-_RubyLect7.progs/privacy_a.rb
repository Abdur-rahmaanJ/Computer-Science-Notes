#!/usr/bin/ruby -w
# PRIVACY_A
# Copyright Mark Keane, All Rights Reserved, 2011

class Testo 
	def initialize
		@foo = "heeeee"
	end
	
	def santa
		p @foo + "  Hooooo, " + snooty
		p self.wicked_elf
	end
	
	def wicked_elf
		@foo + @foo + @foo
	end
	
	def snooty
		"I do not laugh"
	end
	
	public :santa
	protected :wicked_elf
	private :snooty
end

test = Testo.new
test.santa
puts "***************"
test.wicked_elf
#p test.snooty


