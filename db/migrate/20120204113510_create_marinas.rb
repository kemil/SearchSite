class CreateMarinas < ActiveRecord::Migration
  def change
    create_table :marinas do |t|
      t.string :name
      t.decimal :latitude, :precision => 6, :scale => 6
      t.decimal :longitude, :precision => 6, :scale => 6
      t.string :address
      t.references :country
      t.integer :activated, :default => 0

      t.timestamps
    end
    
    add_index(:marinas, :country_id)
  end
end
