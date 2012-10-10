require 'test_helper'

class Principal::BoatReservationControllerTest < ActionController::TestCase

  test "should require login to be accessible, deny without" do
    get :index
    assert_response :redirect
  end

end
