require 'test_helper'
require 'json'

require File.dirname(__FILE__) + '/base_test.rb'

class Api::V1::PrincipalsControllerTest < Api::V1::BaseTest
  test "list principals" do
    setup_request_default
    
    get :list
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert result.has_key?('principals')
  end
  
  test "create principal" do
    setup_request_default
    
    post :create, {name: 'Snake', supplier_guid: 'snake'}
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
  end
  
  test "create principal but already exist" do
    setup_request_default
    
    p = principals(:principal1)
    post :create, {name: p.name, supplier_guid: p.supplier_guid}
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end
end
