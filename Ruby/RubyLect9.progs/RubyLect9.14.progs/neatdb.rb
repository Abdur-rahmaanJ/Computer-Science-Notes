require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => "memory")


class Country < ActiveRecord::Base
    has_many :regions
end

class Region < ActiveRecord::Base
    belongs_to :country
end


if (Country.table_exists? || Region.table_exists?)
  puts "table exists"
  else  ActiveRecord::Schema.define do
          create_table :countries do |table|
            table.column :name, :string
            table.column :continent, :string
            table.column :size, :integer
        end
          create_table :regions do |table|
            table.column :country_id, :integer
            table.column :region_size, :integer
            table.column :name, :string
    end
  end
end

country = Country.create(:name => 'Ireland', :continent => 'Europe', :size => 84421)
country.regions.create(:region_size => 20000, :name => 'Leinster')
country.regions.create(:region_size => 22000, :name => 'Munster')
country.regions.create(:region_size => 12421, :name => 'Connaght')
country.regions.create(:region_size => 30000, :name => 'Ulster')

country = Country.create(:name => 'Belgium', :continent => 'Europe', :size => 30528)
country.regions.create(:region_size => 21000, :name => 'Walloon')
country.regions.create(:region_size => 9000, :name => 'Flemish')
country.regions.create(:region_size => 528, :name => 'Brussels')

p Country.all
p Region.all
p Region.first
p Region.find(7)
#p Region.find(200)     throws a ruby error, assuming there is no 200th region to find
out = Country.all; out.each{|place| p place.name}
p Region.find_by_name("Walloon")
p Region.find_by_region_size(9000)
p Country.where("continent = 'Europe'")
p Country.where("continent = 'Europe' AND size = 30528")
p Region.where("name like '%ster'")

=begin
# -- create_table(:countries)
#    -> 0.1219s
# -- create_table(:regions)
#    -> 0.0021s
#<ActiveRecord::Relation [#<Country id: 1, name: "Ireland", continent: "Europe", size: 84421>, #<Country id: 2, name: "Belgium", continent: "Europe", size: 30528>]>
#<ActiveRecord::Relation [#<Region id: 1, country_id: 1, region_size: 20000, name: "Leinster">, #<Region id: 2, country_id: 1, region_size: 22000, name: "Munster">, #<Region id: 3, country_id: 1, region_size: 12421, name: "Connaght">, #<Region id: 4, country_id: 1, region_size: 30000, name: "Ulster">, #<Region id: 5, country_id: 2, region_size: 21000, name: "Walloon">, #<Region id: 6, country_id: 2, region_size: 9000, name: "Flemish">, #<Region id: 7, country_id: 2, region_size: 528, name: "Brussels">]>
#<Region id: 1, country_id: 1, region_size: 20000, name: "Leinster">
#<Region id: 7, country_id: 2, region_size: 528, name: "Brussels">
"Ireland"
"Belgium"
#<Region id: 5, country_id: 2, region_size: 21000, name: "Walloon">
#<Region id: 6, country_id: 2, region_size: 9000, name: "Flemish">
#<ActiveRecord::Relation [#<Country id: 1, name: "Ireland", continent: "Europe", size: 84421>, #<Country id: 2, name: "Belgium", continent: "Europe", size: 30528>]>
#<ActiveRecord::Relation [#<Country id: 2, name: "Belgium", continent: "Europe", size: 30528>]>
#<ActiveRecord::Relation [#<Region id: 1, country_id: 1, region_size: 20000, name: "Leinster">, #<Region id: 2, country_id: 1, region_size: 22000, name: "Munster">, #<Region id: 4, country_id: 1, region_size: 30000, name: "Ulster">, #<Region id: 8, country_id: 3, region_size: 20000, name: "Leinster">]>
=end