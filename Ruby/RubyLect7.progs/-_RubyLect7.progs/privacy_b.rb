#!/usr/bin/ruby -w
# PRIVACY
# Copyright Mark Keane, All Rights Reserved, 2010

class Testo 

	def santa
		puts "Hooooo  " + self.wicked_elf
		puts "Hooooo  " + self.snooty
	end

	def wicked_elf
		"I am a laughing elf"
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
