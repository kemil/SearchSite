require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, :identifier => trips(:johnstrip).identifier

    assert_response :success
    assert_not_nil assigns(:trip)
    assert_not_nil assigns(:trip).boat_reservations
    assert_not_nil assigns(:trip).invoices
  end

end
