#!/opt/local/bin/ruby2.0 -w
# PASSING METHODS IN CLOSURES
# In part from
# http://www.randomhacks.net/articles/2007/02/01/some-useful-closures-in-ruby

def complement(fn)
  lambda {|arg| not fn.call(arg) }
end

is_even = lambda {|n| n % 2 == 0 }
is_odd  = complement(is_even)

p is_even.call(1)
p is_even.call(4)

p is_odd.call(1)
p is_odd.call(4)

puts "\nAnd then the string one..."

is_string = lambda {|n| n.instance_of?(String) }
is_not_string  = complement(is_string)

p is_string.call("hello")
p is_string.call(:hello)
p is_not_string.call("hello")
p is_not_string.call(:hello)
