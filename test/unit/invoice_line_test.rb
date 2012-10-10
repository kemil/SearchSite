require 'test_helper'

class InvoiceLineTest < ActiveSupport::TestCase
  
  test "calculates total on invoice line" do
    il = InvoiceLine.new(:duecount => 2, :dueamount => 100.01, :duevat => 0.99, :invoice => invoices(:payme))
    assert il.save
    assert_equal il.duetotal, il.duecount * (il.dueamount + il.duevat)
  end
  
end
