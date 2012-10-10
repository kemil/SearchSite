class CreateStandardAttributeMatches < ActiveRecord::Migration
  def change
    create_table :standard_attribute_matches do |t|
      t.string :matcher
      t.references :standard_attribute

      t.timestamps
    end
    
    add_index(:standard_attribute_matches, :standard_attribute_id)
  end
end
