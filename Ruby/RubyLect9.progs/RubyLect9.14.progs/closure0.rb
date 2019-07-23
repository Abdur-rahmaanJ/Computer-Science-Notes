# From
#http://samdanielson.com/2007/9/6/an-introduction-to-closures-in-ruby

=begin
closures = []
(0..7).each { |n|  closures << lambda { n } }

#n => NameError: undefined local variable or method ...
p closures 
p closures.map { |c| c.call }
n = 3
p closures.map { |c| c.call }
=end


no = 0
closures = []
(0..7).each { |n|  closures << lambda { n + no } }
p closures
p closures.map { |c| c.call }
no = 3
p closures.map { |c| c.call }