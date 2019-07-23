###########
# READER
## Copyright Mark Keane, All Rights Reserved, 2013


filo = File.open("info.txt", "r")

filo.each_line {|line| puts line + " tag"}

p open('info.txt') {|f| f.read}

p open('info.txt') {|f| f.readlines}
