class CreateStandardAttributes < ActiveRecord::Migration
  def change
    create_table :standard_attributes do |t|
      t.string :description
      t.string :valuetype

      t.timestamps
    end
  end
end
