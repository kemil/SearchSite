class CreateInvoiceLines < ActiveRecord::Migration
  def change
    create_table :invoice_lines do |t|
      t.references :invoice
      t.string :description
      t.integer :duecount
      t.decimal :dueamount, :precision => 10, :scale => 2
      t.decimal :duevat, :precision => 10, :scale => 2
      t.decimal :duetotal, :precision => 10, :scale => 2

      t.timestamps
    end

    add_index :invoice_lines, :invoice_id
  end
end
