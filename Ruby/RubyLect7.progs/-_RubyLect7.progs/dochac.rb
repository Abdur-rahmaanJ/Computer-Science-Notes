# DOCHAC
# Copyright Mark Keane, All Rights Reserved, 2013

require 'nokogiri'
require 'pp'

file = File.open("feet/feet.html")
doc = Nokogiri::HTML(file)
#pp doc
# where feet/ is a folder within the directory I am working from.
# could just as well be...

#elements = doc.xpath("//h3")  #give me all elements named h3, search works too
#elements = doc.xpath("/html")  #absolute path...

elements = doc.xpath("/html/body//p")
p elements
#gives you all the parts of the body in an array

#[#<Nokogiri::XML::Element:0x3c544c name="p" 
#children=[#<Nokogiri::XML::Text:0x3c2f94 "Hi, welcome to Mark's many feet emporium. for many years I have been roaming the world\ntaking pictures of my feet.  The idea was to create a game where you had to guess where \nthe feet were now. Consider some examples...">]>, #<Nokogiri::XML::Element:0x3eb46c name="p" children=[#<Nokogiri::XML::Text:0x3eb0f2 "Cool..eh ?">]>, 
#<Nokogiri::XML::Element:0x3eae22 name="p"
# children=[#<Nokogiri::XML::Text:0x3eaaa8 "So, I am going to put them all in a table below:\nand your task is to guess the place they are from.">]>, #<Nokogiri::XML::Element:0x3fda54 name="p" children=[#<Nokogiri::XML::Text:0x3fd6da "Well how did you fare? For more links on me go to:">]>, 
#<Nokogiri::XML::Element:0x88167a name="p" children=[#<Nokogiri::XML::Text:0x881300 "Was it good fun?">]>]

p elements.length 
p elements.last
p elements.last.inner_html
p elements.last.inner_text
# $ruby dochac.rb
# #<Nokogiri::XML::Element:0x3d996a name="p" children=[#<Nokogiri::XML::Text:0x3d94e2 "Was it good fun?">]>
# "Was it good fun?"
# "Was it good fun?"

elements2 = doc.xpath("/html/body//table")
#p elements2
#gives you both tables

elements3 = doc.xpath("//td")
#gives you all the td parts of all the tables, very big list.
#p elements3[7]
#p elements3[7].inner_html
#p elements3[7].inner_text
# #<Nokogiri::XML::Element:0x3cacc6 name="td" children=[#<Nokogiri::XML::Element:0x3ca9d8 name="img" attributes=[#<Nokogiri::XML::Attr:0x3ca92e name="src" value="feet2.jpg">, #<Nokogiri::XML::Attr:0x3ca924 name="width" value="104">, #<Nokogiri::XML::Attr:0x3ca91a name="height" value="142">]>]>
# "<img src=\"feet2.jpg\" height=\"142\" width=\"104\" />"
# ""

elements4 = doc.xpath("//img")
#p elements4
#gives you all the images in the body of the doc


def search_for_image_names(parse_a)
	parse_a.search("//td").each do |td_element|
		 imgs = td_element.search("img")
		 if imgs.any?
		 	then imgs.each {|image| puts "Found Image called #{image[:src]}"}
     	 end
	   end
end

search_for_image_names(elements4)
# Found Image called feet1.jpg
# Found Image called feet2.jpg
# Found Image called feet3.jpg
# Found Image called feet4.jpg
# Found Image called feet5.jpg
# Found Image called feet6.jpg
