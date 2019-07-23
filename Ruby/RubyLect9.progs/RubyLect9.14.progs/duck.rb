class Duck

  def quack
    'Quack!'
  end

  def swim
     'Paddle paddle paddle...'
  end
end

class Goose

  def honk
    'Honk!'
  end

  def swim
    'Splash splash splash...'
  end
end

class DuckRecord

  def quack
    play
  end

  def play
   'Quaaaack!'
  end
end

def make_it_quack(duck)
    duck.quack
end

def make_it_swim(duck)
  duck.swim
end

puts make_it_quack(Duck.new)
puts make_it_quack(DuckRecord.new)

puts make_it_swim(Duck.new)
puts make_it_swim(Goose.new)