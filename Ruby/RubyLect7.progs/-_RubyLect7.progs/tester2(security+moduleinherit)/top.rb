require_relative 'terstmodule'
require_relative 'classes'

puts "lets run Topper..."

obj = Topper.new
obj.do_it
obj.try_this
#obj.tryanother            throws error when called like this, but works within try_this
#obj.tryathurd             throws error when called like this, but works within try_this

puts "\n\n Now let's do bottomer...\n\n"

obj2 = Bottomer.new
obj2.do_it
obj2.try_this
#obj2.tryanother             throws error when called like this, but works within try_this
#obj2.tryathurd             throws error when called like this, but works within try_this
obj2.bottomer

