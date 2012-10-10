class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
      t.integer :width
      t.integer :height
      t.references :imageable, :polymorphic => true
      t.string :description
      t.timestamps
    end

    add_index :pictures, [:imageable_type, :imageable_id]
  end
end
