class RemoveTableRegionsSupplierMarinas < ActiveRecord::Migration
  def up
    drop_table :regions_supplier_marinas
  end

  def down
    create_table :regions_supplier_marinas, :id => false do |t|
      t.belongs_to :region, :supplier_marina
      t.timestamps
    end
  end
end
