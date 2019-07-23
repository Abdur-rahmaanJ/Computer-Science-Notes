#!/usr/bin/ruby -w
# UPDATED FOR CATEGORIES
# Copyright Mark Keane, All Rights Reserved, 2011

class Song
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

end

foo = Song.new("Bring in the Clowns","Krusty's Greatest","Krusty", 4.3)
bar1 = Song.new("Bring in the Clowns","Krusty's Greatest","Krusty", 4.3)
bar2 = Song.new("Bring in the Clowns","Liza's Greatest","Minelli", 4)

p foo == foo
p foo == bar1
p foo <=> bar1
p bar2 < bar1
# 
# ruby song_again.rb
# true
# false
# nil
# undefined method `<' for #<Song:0x27498> (NoMethodError)
