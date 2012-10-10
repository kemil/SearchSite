require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  
  test "should get show" do
    get :show, :id => invoices(:displayme).identifier
    
    assert_response :success
    assert_not_nil assigns(:invoice)
    assert_not_nil assigns(:invoice).trip
    assert_not_nil assigns(:invoice).trip.boat_reservations

  end

end
