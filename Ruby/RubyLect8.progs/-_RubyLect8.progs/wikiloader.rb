#!/opt/local/bin/ruby1.9 -w
#  WIKILOADER
#  Created by Mark Keane on 27/09/2011.
#  Copyright (c) 2011 Mark Keane. All rights reserved.

# WIKILOADER: This attempts to loads the uri and catches most of the errors that 
# can occur; it runs quite happily using the OpenURI error catch, but as you get
# into longer runs (like beyond 1 hour) the others show their faces. Its a predicate.


module WikiLoader 
	def self.get_page?(uri, out = [])
   	  puts "\nChecking the following: #{uri}" 
   	  begin
  	  	doc = open(uri, :allow_redirections => :safe)
  	  rescue OpenURI::HTTPError => the_error
  	    puts "Errror, bad status code: #{the_error}"
	    rescue Errno::ENOENT => the_error
	         puts "Error ENOCENT code: #{the_error}"
	    rescue Errno::EHOSTUNREACH => the_error
   		     puts "Error, request for a page #{uri} was unreachable."
      rescue SocketError => the_error
   		     puts "Error, request for a page #{uri} threw a SocketError."
	    rescue Errno::ETIMEDOUT => the_error
   		 puts "Error, request for a page #{uri} threw a TimeoutError."
	    end
   	  if the_error then puts "...so, we are not doing #{uri}"; return false
	  else true end
	end
end

