require 'test_helper'

class MarinaTest < ActiveSupport::TestCase

  test "find only activated marinas" do
    result = Marina.find_names('mar')
    assert_equal(2, result.length)

    result = Marina.find_names('Marina3')
    assert_equal(0, result.length)
  end

  test "find with marina names -- prefix match" do
    result = Marina.find_names('mar')
    assert_equal(2, result.length)

    result = Marina.find_names('marina1')
    assert_equal(1, result.length)
  end

  test "find with marina names -- match anywhere" do
    result = Marina.find_names('rina')
    assert_equal(2, result.length)

    result = Marina.find_names('rina2')
    assert_equal(1, result.length)
  end

  test "find  with marina names -- no match" do
    result = Marina.find_names('marina1a')
    assert_equal(0, result.length)
  end
  
  test "find with country names -- prefix match" do
    result = Marina.find_names('cro')
    assert_equal(1, result.length)
  end

  test "find with country names -- match anywhere" do
    result = Marina.find_names('don')
    assert_equal(1, result.length)
  end

  test "find with country names -- no match" do
    result = Marina.find_names('aa')
    assert_equal(0, result.length)
  end
  
  test "find with region names -- prefix match" do
    result = Marina.find_names('ka')
    assert_equal(1, result.length)
  end

  test "find with region names -- match anywhere" do
    result = Marina.find_names('awa')
    assert_equal(1, result.length)
  end

  test "find  with region names -- no match" do
    result = Marina.find_names('bb')
    assert_equal(0, result.length)
  end
  
  test "find  with inactive marina names -- not found" do
    result = Marina.find_names('marina3')
    assert_equal(0, result.length)
  end

  test "find  with inactive region names -- not found" do
    result = Marina.find_names('lik')
    assert_equal(0, result.length)
  end

  test "find  with inactive country names -- not found" do
    result = Marina.find_names('un')
    assert_equal(0, result.length)
  end
  
end
