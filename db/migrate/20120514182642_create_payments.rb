class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :invoice
      t.string :psp
      t.string :externalref
      t.decimal :amount, :precision => 10, :scale => 2
      t.string :currency

      t.timestamps
    end
    
    add_index :payments, :invoice_id
  end
end
