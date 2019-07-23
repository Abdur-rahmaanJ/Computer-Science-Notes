###########
#  BLOCK
## Copyright Mark Keane, All Rights Reserved, 2013

def block_eg
  puts "this is the first message"
  yield
  puts "this is the middle message"
  yield
  puts "this is the last\n\n"
end

block_eg {puts "-------CUT HERE-------"}

def block_with_args
  puts "First we say this"
  yield("CUT", "HERE")
  puts "this is bit we cut out"
  yield("CUT", "AGAIN HERE")
  puts "this is the last"
end

block_with_args {|a, b| puts "---#{a} #{b}---"}