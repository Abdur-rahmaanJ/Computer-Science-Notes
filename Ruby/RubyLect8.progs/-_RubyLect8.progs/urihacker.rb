#  URIHACKER
#  Created by Mark Keane on 27/09/2011.
#  Copyright (c) 2011 Mark Keane. All rights reserved.

require 'uri'   # we use this gem that chacks the goodness of uri's (see URI::regexp)

# This module has a set of methods that hack http strings from wikipedia.
# They are introduced into the program by including the module in the String class
# (see the sixtop.rb file).

module Urihacker

# STRIP_OUT_NAME: Takes a http-uri from wikipedia and finds the part of it
# that is the name of the film/actor which is returns.  

  def strip_out_name
	 if self =~ /^http:\/\/en.wikipedia.org\/wiki\//
		 then name = self.gsub(/http:\/\/en.wikipedia.org\/wiki\//, "")
	 elsif self =~ /^en.wikipedia.org\/wiki\//
		 then name = self.gsub(/en.wikipedia.org\/wiki\//, "")
	 elsif self =~ /^\/wiki\//
		 then name = self.gsub(/\/wiki\//, "")
	 elsif !(self =~ URI::regexp)
		then print "URI looks bad; can't strip name: "; p "#{self}"; name = self
	 end
	name
  end


# ADD_TAG: Adds the actor/film bracked ending to a http-string.  Most
# page refs to wikipages have this at the end of the name to disambiguate
# it within Wikipedia.

  def add_tag(tag)
	if tag == :actor
		then return self + "_(actor)"
	elsif tag == :film
		then return self + "_(film)"
	end
  end 


# ADD_FULL_URI: Takes the name of an actor/film as a string and adds the http wikipedia path

  def add_full_uri
		   "http://en.wikipedia.org/wiki/" + self
  end


# MAKE_WIKI_URI: checks to see whether the uri has the right start-bit to make a 
# successful wikipedia search; if it has not it fixes it and returns it.

  def make_wiki_uri
	if  self =~ /\/wiki/  && !( self =~ /en.wikipedia.org/) 
		then  return "http://en.wikipedia.org" + self
		else puts "Given non-wiki uri in make_wiki_uri: #{ self}"; return self end
  end
  
# CAPITALISE_URL_NAME: is a bit of a hack.  Sometimes the names of a film/actor have lower case
# words, which interferes with its use as a link; so this takes the uri apart, capitalises the name
# and then puts it all back together again.

  def capitalise_uri_name
	 name_of_film_or_actor = self.split("/").last
 	 new_name = name_of_film_or_actor.split("_").collect {|word| word.capitalize}
	 new_name_merged = new_name.inject{|a,b| a + "_" + b}
	 "http://en.wikipedia.org/wiki/" +  new_name_merged
  end

end

