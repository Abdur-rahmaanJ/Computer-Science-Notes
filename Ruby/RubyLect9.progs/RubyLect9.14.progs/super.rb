class Foo
  def foo_it
    puts "Do foo first..."
  end
end


class FooLet < Foo
  def foo_it
    super
    puts "Then do the rest..."
  end
end


a =  Foo.new
b = FooLet.new
a.foo_it
puts "\n"
b.foo_it
