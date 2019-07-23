#!/opt/local/bin/ruby2.0 -w
# PASSING METHODS IN CLOSURES
# From http://www.randomhacks.net/articles/2007/02/01/some-useful-closures-in-ruby

def compose (f, g)
  lambda {|arg| f.call(g.call(arg)) }
end

mult2 = lambda {|n| n*2 }
add1  = lambda {|n| n+1 }
mult2_add1 = compose(add1, mult2)

p mult2_add1.call(3)
