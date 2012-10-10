require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase

	# /pay/callback/LHIOCMRS-1/1,00/EUR/D/156372392/MAC=8BB740371255D96FDC20EED59762F644
  test "return easypay verification text, even for failures" do
    get(:callback, {:sum => "1,00", :currency => 'EUR', :reply => 'D', :id => '23434234', :mac => 'MAC=8BB740371255D96FDC20EED59762F644', :invoice => 'HJAHWJSH-1'})
    assert_response :success
    assert_match "<!-- VerifyEasy_response:_OK -->", @response.body
  end

  test "save the payment to the trip" do
    get(:callback, {:sum => "1,00", :currency => 'EUR', :reply => 'A', :id => '23434234', :mac => 'MAC=0EAC159EE1671A048A70BE743729DC19', :invoice => 'QWERTYUI-1'})
    assert_response :success
    assert_match "<!-- VerifyEasy_response:_OK -->", @response.body
    assert_equal 1, Invoice.find_by_identifier("QWERTYUI-1").payments.count
  end

  test "send customer coming back to the trips page" do
    get(:arrive, {:reply => 'A',  :invoice => 'QWERTYUI-1'})
    assert_redirected_to trip_path(assigns(:invoice).trip)
  end


end
