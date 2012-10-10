class AddDescriptionToBoatModels < ActiveRecord::Migration
  def change
    add_column :boat_models, :description, :text
  end
end
