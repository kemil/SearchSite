class FixGeolocationScale < ActiveRecord::Migration
  ## the proper way to declare longitude
  ## http://earthcode.com/blog/2006/12/latitude_and_longitude_columns.html
  
  def up
    change_column :supplier_marinas, :longitude, :decimal, :precision => 15, :scale => 10 
    change_column :supplier_marinas, :latitude, :decimal, :precision => 15, :scale => 10 
    
    change_column :marinas, :longitude, :decimal, :precision => 15, :scale => 10 
    change_column :marinas, :latitude, :decimal, :precision => 15, :scale => 10
  end

  def down
    change_column :supplier_marinas, :longitude, :decimal, :precision => 6, :scale => 6
    change_column :supplier_marinas, :latitude, :decimal, :precision => 6, :scale => 6
    
    change_column :marinas, :longitude, :decimal, :precision => 6, :scale => 6
    change_column :marinas, :latitude, :decimal, :precision => 6, :scale => 6
  end
end
