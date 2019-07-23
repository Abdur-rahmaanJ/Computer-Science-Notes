##############
# SIMPLE READER
## Copyright Mark Keane, All Rights Reserved, 2013

require 'csv'


CSV.foreach("people0.csv", :headers => true) do |row|
    p row
	end

CSV.foreach("people0.csv") do |row|
    p row
end


CSV.foreach("people0.csv") do |row|
    puts row[1]
	end
