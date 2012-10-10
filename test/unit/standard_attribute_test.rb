require 'test_helper'

class StandardAttributeTest < ActiveSupport::TestCase

  test "standardize_value booleans" do
  	bool = StandardAttribute.create(description: 'bool', valuetype: 'boolean')

    assert_equal "true", bool.standardize_value("1")
    assert_equal "true", bool.standardize_value("true")
    assert_equal "true", bool.standardize_value("yEs")
    assert_equal "false", bool.standardize_value("0")
    assert_equal "false", bool.standardize_value("False")
    assert_equal "false", bool.standardize_value("NO")
  end

  test "standardize_value integers" do
  	integer = StandardAttribute.create(description: 'int', valuetype: 'integer')

    assert_equal "1", integer.standardize_value("1")
    assert_equal "500", integer.standardize_value("hello 500 elephants")
  end

  test "standardize_value decimals" do
   	dec = StandardAttribute.create(description: 'dec', valuetype: 'decimal')

    assert_equal "1.0", dec.standardize_value("1")
    assert_equal "1.0", dec.standardize_value("1.0")
    assert_equal "1.0", dec.standardize_value(" 1.00 ")
    assert_equal "2000.23", dec.standardize_value("test 2000.23 end")
  end

  test "standardize_value strings" do
   	str = StandardAttribute.create(description: 'str', valuetype: 'string')

    assert_equal "string", str.standardize_value("string")
    assert_equal "100", str.standardize_value("100")
  end


end
