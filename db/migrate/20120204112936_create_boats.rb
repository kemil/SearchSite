class CreateBoats < ActiveRecord::Migration
  def change
    create_table :boats do |t|
      t.string :supplier_guid
      t.references :supplier
      t.string :name
      t.string :model_name
      t.integer :model_year
      t.string :description
      t.references :supplier_marina
      t.references :principal
      t.references :boat_model
      t.integer :activated, :default => 0
      t.string :hull
      t.integer :length_ft
      t.integer :cabins
      t.integer :berths
      t.integer :heads
      t.integer :max_persons
      t.integer :fuel_capacity
      t.integer :water_capacity
      t.timestamps
    end
    
    add_index(:boats, :supplier_id)
    add_index(:boats, :supplier_marina_id)
    add_index(:boats, :principal_id)
    add_index(:boats, :boat_model_id)
  end
end
