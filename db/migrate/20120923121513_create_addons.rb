class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|
      t.string :name
      t.string :title_key
      t.string :description_key
      t.string :invoice_line_key
      t.decimal :per_booking_price,   :precision => 10, :scale => 2
      t.decimal :per_night_price,   :precision => 10, :scale => 2
      t.integer :activated,  :default => 1

      t.timestamps
    end
  end
end
