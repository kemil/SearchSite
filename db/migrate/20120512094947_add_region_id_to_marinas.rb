class AddRegionIdToMarinas < ActiveRecord::Migration
  def self.up
    add_column :marinas, :region_id, :integer
    add_index :marinas, :region_id
    
    add_column :supplier_marinas, :region_id, :integer
    add_index :supplier_marinas, :region_id
  end
  def self.down
    remove_column :supplier_marinas, :region_id
    remove_column :marinas, :region_id
  end
end
