class AddActivatedToTables < ActiveRecord::Migration
  def change
    add_column :regions, :activated, :integer, :default => 1
    add_column :countries, :activated, :integer, :default => 1
  end
end
