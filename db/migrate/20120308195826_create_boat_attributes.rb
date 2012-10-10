class CreateBoatAttributes < ActiveRecord::Migration
  def change
    create_table :boat_attributes do |t|
      t.string :description
      t.string :value
      t.references :boat

      t.timestamps
    end
    
    add_index(:boat_attributes, :boat_id)
  end
end
