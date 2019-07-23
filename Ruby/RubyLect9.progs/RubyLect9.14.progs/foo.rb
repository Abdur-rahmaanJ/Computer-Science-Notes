class Foo
	def check
		p "foo"
	end
	
	def self.checko
		p "foo class method"
	end
end

x = Foo.new

#All these are good and work
x.check
Foo::checko
Foo.checko

#But, this does not work
#foo.rb:17:in `<main>': undefined method `check' for Foo:Class (NoMethodError)
#Foo::check

module Freaky
	class Basic
	   def do_it
	     p "do it"
	   end
	   
	   def self.do_again
	     p "do again class method"
	   end
	end
end

# All these are good and work
b = Freaky::Basic.new
b.do_it
Freaky::Basic.do_again
Freaky::Basic::do_again

#But, this does not work
# foo.rb:35:in `<main>': undefined method `Basic' for Freaky:Module (NoMethodError)
#Freaky.Basic.do_again

# Neither does this...
# foo.rb:35:in `<main>': uninitialized constant Object::Basic (NameError)
b = Basic.new
b.do_it


