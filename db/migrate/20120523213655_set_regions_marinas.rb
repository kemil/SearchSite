class SetRegionsMarinas < ActiveRecord::Migration
  def up
    remove_column :supplier_marinas, :region_id
    remove_column :marinas, :region_id
    
    create_table :regions_supplier_marinas, :id => false do |t|
      t.belongs_to :region, :supplier_marina
      t.timestamps
    end
    
    create_table :marinas_regions, :id => false do |t|
      t.belongs_to :region, :marina
      t.timestamps
    end
  end

  def down
    add_column :marinas, :region_id, :integer
    add_index :marinas, :region_id
    
    drop_table :regions_supplier_marinas
    drop_table :marinas_regions
  end
end
