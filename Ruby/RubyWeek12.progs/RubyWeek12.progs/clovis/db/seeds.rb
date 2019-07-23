# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Song.create(:name => 'The End', :artist => 'Doors', :album => 'Greatest Hits')
Song.create(:name => 'Red Hot', :artist => 'RHCP', :album => 'What Hits')
Song.create(:name => 'Solid Air', :artist => 'John Martyn', :album => 'Solid Air')
Song.create(:name => 'May You Never', :artist => 'John Martyn', :album => 'Solid Air')
Song.create(:name => 'May You Never', :artist => 'Eric Clapton', :album => 'Clap Hits')