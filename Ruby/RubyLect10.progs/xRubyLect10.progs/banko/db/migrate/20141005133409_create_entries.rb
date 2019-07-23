class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :first_name
      t.string :last_name
	    t.string :address
	    t.integer :loan
	    t.string :loan_reason
	    t.integer :salary
      t.timestamps
    end
  end
end

