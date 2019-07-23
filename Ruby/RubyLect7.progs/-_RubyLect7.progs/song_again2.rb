#!/usr/bin/ruby -w
# SONG_AGAIN2
# Copyright Mark Keane, All Rights Reserved, 2010

class Song
	include Comparable
	attr_accessor :name, :album, :artist, :time, :id, :in_libs
	def initialize(name, album, artist, time)
		@name = name
		@album = album
		@time = time
		@artist = artist
	end
	
	def to_s
		puts "<< #{@name} >> by #{@artist} in their album #{@album}.\n"
	end	
	
	def <=>(song2)
		self.time <=> song2.time
	end
	
end

foo = Song.new("Bring in the Clowns","Krusty's Greatest","Krusty", 4.3)
bar1 = Song.new("Bring in the Clowns","Krusty's Greatest","Krusty", 4.3)
bar2 = Song.new("Bring in the Clowns","Liza's Greatest","Minelli", 4)

p foo == foo
p foo == bar1
p bar2 <=> foo
p foo <=> bar1
p foo <=> bar2
p bar2 < bar1
p bar2 > bar1

# ruby song_again2.rb
# true
# true
# -1
# 0
# 1
# true
# false