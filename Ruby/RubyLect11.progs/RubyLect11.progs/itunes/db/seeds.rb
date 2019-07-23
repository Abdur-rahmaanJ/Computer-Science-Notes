# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Actor.create(:name => 'Mark', :likes => 'reggae', :status  => 'Admin', :id => 1)
Actor.create(:name => 'Bloggie', :likes => 'punk', :status  => 'Buyer', :id => 2)
Song.create(:title => 'Stairway to Heaven', :artist => 'Led Zep', :time  => 4, :in_album => 'Led Zep IV', :actor_id => 1)
Song.create(:title => 'Holiday', :artist => 'Sex Pistols', :time  => 2, :in_album => 'God Save...', :actor_id => 2)