class CreateBoatModels < ActiveRecord::Migration
  def change
    create_table :boat_models do |t|
      t.string :name

      t.timestamps
    end
  end
end
