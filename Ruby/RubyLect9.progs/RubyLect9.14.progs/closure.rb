#!/opt/local/bin/ruby2.0 -w
# CLOSURE
# Copyright Mark Keane, All Rights Reserved, 2011

arr1 = ["john", "jim","mary", "james"]
arr2 = ["A", "B","C", "D"]

def assign_marks(people, marks, time1 = 0, procs = [])
	people.each do |person|
		time2 = 0
		marks.each do |mark|
		fn = lambda {p [person, mark, time1, time2]}
		procs << fn
		fn.call; time1 += 1; time2 += 1
		if (time1 == 10 || time2 == 4)
		then puts "Encountered an error at 10/4 seconds, going back to start" 
			 procs.first.call end
	  end
	end
    procs
end

fns = assign_marks(arr1, arr2)
p fns
fns.each {|clos| clos.call}


=begin
dhcp-892b3c12:RubyWeek8.progs mkeane$ !!
ruby closure.rb
["john", "A", 0, 0]
["john", "B", 1, 1]
["john", "C", 2, 2]
["john", "D", 3, 3]
Encountered an error at 10/4 seconds, going back to start
["john", "A", 4, 4]
["jim", "A", 4, 0]
["jim", "B", 5, 1]
["jim", "C", 6, 2]
["jim", "D", 7, 3]
Encountered an error at 10/4 seconds, going back to start
["john", "A", 8, 4]
["mary", "A", 8, 0]
["mary", "B", 9, 1]
Encountered an error at 10/4 seconds, going back to start
["john", "A", 10, 4]
["mary", "C", 10, 2]
["mary", "D", 11, 3]
Encountered an error at 10/4 seconds, going back to start
["john", "A", 12, 4]
["james", "A", 12, 0]
["james", "B", 13, 1]
["james", "C", 14, 2]
["james", "D", 15, 3]
Encountered an error at 10/4 seconds, going back to start
["john", "A", 16, 4]
[#<Proc:0x007fdc4384cf20@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384cd68@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384cc28@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384cae8@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384c840@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384c700@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384c5c0@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384c480@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384c200@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384c0c0@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384be68@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384bd28@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384baa8@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384b968@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384b828@closure.rb:12 (lambda)>, #<Proc:0x007fdc4384b6e8@closure.rb:12 (lambda)>]
["john", "A", 16, 4]
["john", "B", 16, 4]
["john", "C", 16, 4]
["john", "D", 16, 4]
["jim", "A", 16, 4]
["jim", "B", 16, 4]
["jim", "C", 16, 4]
["jim", "D", 16, 4]
["mary", "A", 16, 4]
["mary", "B", 16, 4]
["mary", "C", 16, 4]
["mary", "D", 16, 4]
["james", "A", 16, 4]
["james", "B", 16, 4]
["james", "C", 16, 4]
["james", "D", 16, 4]
dhcp-892b3c12:RubyWeek8.progs mkeane$ 
=end