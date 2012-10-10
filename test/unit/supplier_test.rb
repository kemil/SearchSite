require 'test_helper'

class SupplierTest < ActiveSupport::TestCase
  test "create supplier" do
    s1 = Supplier.new(:name => 's1', :description => 's1 supplier')
    assert s1.save
  end
  
  test "unique name" do
    s1 = suppliers(:supplier1)
    s2 = Supplier.new(:name => 'supplier1', :description => 'algjaldk')
    assert !s2.save
  end
  
  test "find supplier by access token" do
    access_token = suppliers(:supplier1).access_token
    s = Supplier.find_by_access_token( access_token )
    assert !s.blank?
  end
end
