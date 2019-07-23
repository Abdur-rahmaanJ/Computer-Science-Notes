##############
# UPDATED FOR CATEGORIES
## Copyright Mark Keane, All Rights Reserved, 2012

require_relative 'class2a'
require_relative 'class2b'


mark = Testo.new("mark", "keane")
mark.man_name


trip = Visit.new("venice", mark)
trip.print_visit
