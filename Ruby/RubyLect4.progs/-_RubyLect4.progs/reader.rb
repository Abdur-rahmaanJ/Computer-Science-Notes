##############
# SIMPLE READER
## Copyright Mark Keane, All Rights Reserved, 2014

require 'csv'

class Person
	def initialize(fname, surname, age)
		@fname, @surname, @age = fname, surname, age
	end
end

class PimpyReader
	def initialize()
		@people = Array.new
	end
	
	def get_people
		@people
	end

	def read_in_people(file_name)
	  CSV.foreach(file_name, :headers => true) do |row|
			fname, surname, age = row[0],row[1],row[2]
	 	 if  !fname.include?("#")	#if the row doesn't include a hash then read it in
	 	 	then @people << Person.new(fname,surname,age.to_i)
	 	 end
	   end
	  @people
	end
end

reader = PimpyReader.new
#csv_file_name = ARGV[0]       # if running at commandline ...
csv_file_name = "people.csv"    # if running in RubyMine do this...
p csv_file_name
reader.read_in_people(csv_file_name)
reader.get_people.each{|person| p person}


# $ ruby reader.rb people.csv
# "people.csv"
# [#<Person:0x516fe4 @fname="Mark", @surname="Keane", @age=49>,
# #<Person:0x516abc @fname="Mahatma", @surname="Gandi", @age=67>, 
# #<Person:0x516594 @fname="Grommit", @surname="Dog", @age=10>, 
# #<Person:0x51606c @fname="Haroun", @surname="Al-raschid", @age=56>, 
# #<Person:0x515b44 @fname="Regina", @surname="Spector", @age=31>]

# WATCH FOR THIS ERROR: CAUSED bu you not passing the csv.file
# $ ruby reader.rb
# nil
# /opt/local/lib/ruby1.9/1.9.1/csv.rb:1330:in `initialize': can't convert nil into String (TypeError)
# 	from /opt/local/lib/ruby1.9/1.9.1/csv.rb:1330:in `open'
# 	from /opt/local/lib/ruby1.9/1.9.1/csv.rb:1330:in `open'
# 	from /opt/local/lib/ruby1.9/1.9.1/csv.rb:1196:in `foreach'
# 	from reader.rb:23:in `read_in_people'
# 	from reader.rb:35:in `<main>'
