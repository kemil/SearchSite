class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.string :name
      t.string :supplier_guid
      t.references :supplier

      t.timestamps
    end

    add_index(:principals, :supplier_id)
  end
end
