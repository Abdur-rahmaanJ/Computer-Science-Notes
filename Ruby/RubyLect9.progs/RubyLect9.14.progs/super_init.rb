class Foo
  def initialize(a, b)
    @a = a
    @b = b
    @count = 2
  end
end

class FooLet < Foo
  def initialize(a1, b1)
    super
    @count = 4
  end
end

a =  Foo.new(:mark, :keane)
p a
b = FooLet.new(:donald, :duck)
p b