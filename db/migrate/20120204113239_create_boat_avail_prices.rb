class CreateBoatAvailPrices < ActiveRecord::Migration
  def change
    create_table :boat_avail_prices do |t|
      t.references :boat
      t.date :period_start
      t.date :period_end
      t.integer :period_price
      t.integer :period_nights
      t.string :calc

      t.timestamps
    end

    add_index(:boat_avail_prices, :boat_id)
  end
end
