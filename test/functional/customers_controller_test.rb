require 'test_helper'

class CustomersControllerTest < ActionController::TestCase


  test "New Customer Page" do
    boat = Boat.find(2)
    get :new, :permalink =>"3-alice-bavaria-38", :from =>"2012-07-08", :to => '2012-07-22'
    assert_response :success
    assert_not_nil assigns(:customer)
    assert_not_nil assigns(:boat)
    assert_not_nil assigns(:avail_price)

    boat = assigns(:boat)
    assert_equal('Alice', boat.name)
    assert_equal('Bavaria 38', boat.model_name)
    assert_equal('3-alice-bavaria-38', boat.permalink)
    total_price = assigns(:avail_price).total_price.to_i
    assert_equal(10000, total_price)
  end
  
  test "Create Customer Page" do
    boat = Boat.find(2)
    get :create, :customer => {:namefirst =>"David", :namelast => 'Bay', :email => 'david.bay@ylsite.com', :address1 => "address of customer", :town => "Customer's town", :state => "Customer's state", :zipcode => '12345', :country_id => '1', :cellnumber => '123456'}, :boat_id => 2, :from =>"2012-07-08", :to => '2012-07-22'
    assert_response 302
    assert_not_nil assigns(:customer)
    assert_not_nil assigns(:boat)
    assert_not_nil assigns(:trip)
    assert_not_nil assigns(:book_reservation)
    assert_not_nil assigns(:invoice)
    
    customer = assigns(:customer)
    assert_equal customer.to_s, "#{customer.namefirst} #{customer.namelast}"
    assert_equal customer.email, "david.bay@ylsite.com"
    assert_equal customer.cellnumber, "123456"
    
    assert_not_nil customer.trips
    assert_not_nil customer.trips.first.identifier
    assert_equal(assigns(:trip), customer.trips.first)
    
    assert_equal assigns(:book_reservation).boat, assigns(:boat)
    assert_equal assigns(:invoice).trip, assigns(:trip)
    assert_equal assigns(:invoice).invoice_lines.count, 1
  end

end
