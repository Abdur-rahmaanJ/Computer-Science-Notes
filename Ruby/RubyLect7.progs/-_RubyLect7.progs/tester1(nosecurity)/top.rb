require_relative 'terstmodule'
require_relative 'classes'

puts "lets run Topper..."

obj = Topper.new
obj.do_it
obj.try_this
obj.tryanother
obj.tryathurd

puts "\n\n Now let's do bottomer...\n\n"

obj2 = Bottomer.new
obj2.do_it
obj2.try_this
obj2.tryanother
obj2.tryathurd

