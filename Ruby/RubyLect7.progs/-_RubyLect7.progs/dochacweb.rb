#!/usr/bin/ruby -w
# DOCHACWEB
# Copyright Mark Keane, All Rights Reserved, 2013

require 'nokogiri'
require 'open-uri'
require 'pp'


doc = Nokogiri::HTML(open("http://www.ucd.ie"))
#pp doc

elements = doc.xpath("//a[@href]")
p elements.length

p elements[50]
item = elements[50]["href"]
p item
