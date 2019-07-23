require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => "memory")


class Clean < ActiveRecord::Migration	
   def self.up
    create_table :towns do |table|
        table.column :name, :string
        table.column :continent, :string
        table.column :size, :integer
     end
   end

   def self.down
     drop_table :towns
   end
  
end

class Town < ActiveRecord::Base    
end

#Clean.down
Clean.up
     
p Town.create(:name => "ff", :continent => "fa", :size => 333)



