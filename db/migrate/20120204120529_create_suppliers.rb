class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :description
      t.string :access_token

      t.timestamps
    end

    add_index(:suppliers, :access_token)
  end
end
