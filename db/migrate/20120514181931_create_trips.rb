class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :identifier
      t.references :customer

      t.timestamps
    end
  end
end
