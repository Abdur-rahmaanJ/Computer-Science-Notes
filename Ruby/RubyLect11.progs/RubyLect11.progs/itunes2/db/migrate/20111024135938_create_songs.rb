class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
	  t.string :in_album
	  t.integer :time
	  t.string :artist
	  t.integer :actor_id
      t.timestamps
    end
  end
end
