class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.references :trip
      t.string :identifier
      t.string :currency
      t.integer :status
      t.decimal :due_amount, :precision => 10, :scale => 2

      t.timestamps
    end
    
    add_index :invoices, :trip_id
  end
end
