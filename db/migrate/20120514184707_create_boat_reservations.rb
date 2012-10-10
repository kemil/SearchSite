class CreateBoatReservations < ActiveRecord::Migration
  def change
    create_table :boat_reservations do |t|
      t.references :trip
      t.references :boat
      t.integer :status
      t.string :externalref
      t.datetime :rentaltimestart
      t.datetime :rentaltimeend
      t.integer :rentalmarinastart_id
      t.integer :rentalmarinaend_id

      t.timestamps
    end

    add_index :boat_reservations, :trip_id
  end
end
