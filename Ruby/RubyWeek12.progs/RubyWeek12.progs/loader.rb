require 'yaml'

file = File.open('database.txt')

p YAML::load(file)