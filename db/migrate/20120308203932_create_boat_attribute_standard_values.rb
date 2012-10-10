class CreateBoatAttributeStandardValues < ActiveRecord::Migration
  def change
    create_table :boat_attribute_standard_values do |t|
      t.string :value
      t.references :boat_attribute
      t.references :standard_attribute

      t.timestamps
    end
    
    add_index(:boat_attribute_standard_values, :boat_attribute_id)
    add_index(:boat_attribute_standard_values, :standard_attribute_id)
  end
end
