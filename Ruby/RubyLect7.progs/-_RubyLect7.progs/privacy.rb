#!/usr/bin/ruby -w
# PRIVACY
# Copyright Mark Keane, All Rights Reserved, 2010

class Testo 
	def initialize
		@foo = "heeeee"
	end
	
	def santa
		@foo + "  Hooooo"
	end
	
	def wicked_elf
		@foo + @foo + @foo
	end
	
	def snooty
		"I do not laugh"
	end
	
	public :santa, :wicked_elf, :snooty
	protected #  :wicked_elf
	private # :snooty
end

test = Testo.new

#test.initialize
#privacy.rb:21: private method `initialize' called for #<Testo:0x27f38 @foo="heeeee"> (NoMethodError)

p test.santa
p test.wicked_elf
p test.snooty
# All PUBLIC
# ruby privacy.rb
# "heeeee  Hooooo"
# "heeeeeheeeeeheeeee"
# "I do not laugh"

# Santa public, wicket_elf protected, snooty private
# ruby privacy.rb
# "heeeee  Hooooo"
# protected method `wicked_elf' called for #<Testo:0x27aec @foo="heeeee"> (NoMethodError)
# private method `snooty' called for #<Testo:0x27b64 @foo="heeeee"> (NoMethodError)

