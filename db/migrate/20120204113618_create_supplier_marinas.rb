class CreateSupplierMarinas < ActiveRecord::Migration
  def change
    create_table :supplier_marinas do |t|
      t.string :name
      t.decimal :latitude, :precision => 6, :scale => 6
      t.decimal :longitude, :precision => 6, :scale => 6
      t.string :address
      t.references :country
      t.references :marina
      t.string :supplier_guid
      t.references :supplier

      t.timestamps
    end
    
    add_index(:supplier_marinas, :country_id)
    add_index(:supplier_marinas, :marina_id)
    add_index(:supplier_marinas, :supplier_id)
  end
end
