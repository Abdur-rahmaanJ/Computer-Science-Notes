class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.string :likes
	  t.string :status
      t.timestamps
    end
  end
end
