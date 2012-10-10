require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

  test "show generted values" do
		i = Invoice.new(:trip => trips(:johnstrip))
    assert i.save
    assert_equal i.status, 0
    assert_equal i.currency, 'EUR'
    assert_equal i.identifier, "#{i.trip.identifier}-#{i.trip.invoices.count}"
    
  end
  
	test "calculates total on invoice" do
		i = Invoice.new(:identifier => 'abc', :trip => trips(:johnstrip))
		assert i.save
		il1 = i.invoice_lines.build(:duecount => 2, :dueamount => 100.01, :duevat => 0.99)
		il1.save
		i.reload
  	assert_equal "202.0", i.due_amount.to_s
		
		il2 = i.invoice_lines.build(:duecount => 3, :dueamount => 200.99, :duevat => 0.01)
		assert il2.save
		i.reload
  	assert_equal "805.0", i.due_amount.to_s
	end

end
