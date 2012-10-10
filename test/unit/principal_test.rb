require 'test_helper'

class PrincipalTest < ActiveSupport::TestCase
  test "basic create" do
    s = suppliers(:supplier1)
    p = Principal.new(:name => 'test_principal1', 
                      :supplier_guid => 'test_principal1',
                      :supplier => s)
    assert p.save
  end

  test "unique name" do
    s = suppliers(:supplier1)
    p = Principal.new(:name => 'principal one',
                      :supplier_guid => 'principal1',
                      :supplier => s)
    assert !p.save
    p = Principal.new(:name => 'pRincipal one',
                      :supplier_guid => 'principal1',
                      :supplier => s)
    assert !p.save
    p = Principal.new(:name => 'Principal One',
                      :supplier_guid => 'principal1',
                      :supplier => s)
    assert !p.save
  end
end
