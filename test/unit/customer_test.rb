require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  
  test "show user's fullname" do
    customer = customers(:johndoe)
    assert_not_nil customer
    assert_equal customer.to_s, 'Jon Doe'
  end
end
