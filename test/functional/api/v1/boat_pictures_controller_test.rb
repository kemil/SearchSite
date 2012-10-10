require 'test_helper'
require 'json'

require File.dirname(__FILE__) + '/base_test.rb'

class Api::V1::BoatPicturesControllerTest < Api::V1::BaseTest
  test "request using guid" do
    setup_request_default
    
    boat_denis = boats(:denis)

    get :list, {:boat_guid => boat_denis.supplier_guid}
    
    assert_response :success
    
    result = JSON.parse(@response.body)
    puts @response.body
    assert (result['pictures'].length > 0)
  end
  
  test "list boat pictures" do
    setup_request_default
    
    boat_denis = boats(:denis)

    get :list, {:boat_id => boat_denis.id}
    
    assert_response :success
    
    result = JSON.parse(@response.body)
    puts @response.body
    assert (result['pictures'].length > 0)
    assert_equal result['pictures'][0]['width'], boat_denis.pictures.first.width
  end
  
  test "list boat pictures - boat not found" do
    setup_request_default
    
    get :list, {:boat_id => 5102}
    
    assert_response :success
    
    result = JSON.parse(@response.body)

    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end

  test "list boat pictures - no boat id" do
    setup_request_default

    get :list

    result = JSON.parse(@response.body)

    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end

  test "list boat pictures - invalid supplier guid" do
    setup_request_default

    get :list, {:boat_guid => 'invalid_guid'}

    result = JSON.parse(@response.body)

    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end
  
  test "create boat picture" do
    setup_request_default
    
    boat_denis = boats(:denis)
    
    post :create, {
      :boat_id => boat_denis.id, 
      :picture => {
        :url => 'http://www.boatdetailing.org/images/boat_detailing.jpg',
        :width => 480,
        :height => 360,
        :description => 'Ride the tides, follow the winds'
      }
    }
    
    assert_response :success
  end

  test "create -- invalid picture" do
    setup_request_default

    boat_denis = boats(:denis)

    post :create, {
        :boat_id => boat_denis.id,
        :picture => {}
    }

    result = JSON.parse(@response.body)

    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end
  
  test "create boat picture - boat not found" do
    setup_request_default
    
    post :create, {
      :boat_id => 5102,
      :picture => {
        :url => 'http://www.boatdetailing.org/images/boat_detailing.jpg',
        :width => 480,
        :height => 360,
        :description => 'Ride the tides, follow the winds'
      }
    }
    
    assert_response :success
    
    result = JSON.parse(@response.body)

    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end
end
