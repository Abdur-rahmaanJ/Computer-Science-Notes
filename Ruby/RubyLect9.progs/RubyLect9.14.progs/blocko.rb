#!/opt/local/bin/ruby2.0 -w
# BLOCKO
# Copyright Mark Keane, All Rights Reserved, 2014

low_vat_rate = 10
high_vat_rate = 21

blocktest = lambda do |x|
	if x > 100 then p(x * low_vat_rate)
	elsif x < 100 then p(x * high_vat_rate)
	elsif x == 100 then puts "not sure what to do" end
 end
 
blocktest.call(20)
blocktest.call(100)
blocktest.call(500)

# ruby blocko.rb
# 420
# not sure what to do
# 5000