#!/opt/local/bin/ruby2.0 -w
# CUTBLOCK
# Copyright Mark Keane, All Rights Reserved, 2010

def block_eg1(cutblock)
   puts "this is the first message from 1 "
   cutblock.call
   puts "this is the middle message"
   cutblock.call
   puts "this is the last\n\n"
end

ablock = lambda {puts "-------CUT HERE-------"}
block_eg1(ablock)


def block_eg2(&cutblock)
   puts "this is the first message from 2"
   cutblock.call
   puts "this is the middle message"
   cutblock.call
   puts "this is the last\n\n"
end

block_eg2() {puts "-------CUT HERE-------"}

#blox = lambda {puts "-------CUT HERE NOW-------"}
#block_eg2(blox)
#note the above does not work, you have defined block_eg2 to work with a different syntax