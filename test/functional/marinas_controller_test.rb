require 'test_helper'

class MarinasControllerTest < ActionController::TestCase

  test "autocomplete -- basic" do
    get :autocomplete, :term => 'mar'
    assert_response :success

    result = JSON.parse(@response.body)
    assert_equal(2, result.length)
  end

  test "autocomplete -- blank terms" do
    get :autocomplete
    assert_response :success

    result = JSON.parse(@response.body)
    assert_equal(0, result.length)
  end

end