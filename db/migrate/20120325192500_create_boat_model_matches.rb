class CreateBoatModelMatches < ActiveRecord::Migration
  def change
    create_table :boat_model_matches do |t|
      t.string :matcher
      t.references :boat_model

      t.timestamps
    end
    add_index :boat_model_matches, :boat_model_id
  end
end
