require 'test_helper'

class BoatsControllerTest < ActionController::TestCase
  test "should get show from permalink" do
    get :show, :permalink =>"3-alice-bavaria-38", :from =>"2012-08-22", :to => '2012-08-29'
    assert_response :success
    assert_not_nil assigns(:boat)
    assert_not_nil assigns(:avail_price)
    boat = assigns(:boat)
    avail_price = assigns(:avail_price)
    assert_equal('Alice', boat.name)
    assert_equal('Bavaria 38', boat.model_name)
    assert_equal('3-alice-bavaria-38', boat.permalink)
    assert_not_nil boat.supplier_marina
    assert_not_nil boat.principal
    assert_equal(10000, avail_price.total_price.to_i)
  end
  
  test "should not show from permalink" do
    get :show, :permalink =>"4-denis-bavaria-38-cruiser", :from =>"2012-08-08", :to => '2012-08-22'
    assert_response :success
    assert_nil assigns(:boat)
  end
  
end
