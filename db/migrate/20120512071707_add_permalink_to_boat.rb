class AddPermalinkToBoat < ActiveRecord::Migration
  def self.up
    add_column :boats, :permalink, :string
    add_index :boats, :permalink
  end
  def self.down
    remove_column :boats, :permalink
  end
end