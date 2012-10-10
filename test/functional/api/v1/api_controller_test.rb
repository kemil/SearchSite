require 'test_helper'
require 'json'

class Api::V1::ApiControllerTest < ActionController::TestCase
  test "valid API key" do
    s = suppliers(:supplier1)
    @request.env['API-Key'] = s.access_token
    get :version
    assert_response :success, Api::V1::ApiController::VERSION.to_json
  end

  test "invalid API key" do
    @request.env['API-Key'] = 'dummy'
    get :version
    assert_response :unauthorized, Api::V1::ApiCode::INVALID_API_KEY.to_json
  end

  test "environment" do
    s = suppliers(:supplier1)
    @request.env['API-Key'] = s.access_token
    get :environment
    assert_response :success, {:environment => 'test'}.to_json
  end
end
