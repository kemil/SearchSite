class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :namefirst
      t.string :namelast
      t.string :address1
      t.string :address2
      t.string :zipcode
      t.string :town
      t.string :state
      t.references :country
      t.string :email
      t.string :cellnumber

      t.timestamps
    end
  end
end
