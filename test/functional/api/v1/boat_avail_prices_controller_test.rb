require 'test_helper'
require 'json'
require File.dirname(__FILE__) + '/base_test.rb'

class Api::V1::BoatAvailPricesControllerTest < Api::V1::BaseTest
	DATA = {:boat_id => 1, :period_start => "2012-09-09", :period_end => "2012-09-16", :period_price => 5000, :period_nights => 7}

  test "list -- using boat_guid" do
    setup_request_default

    get :list, :boat_guid => 'navigare_denis'
    result = JSON.parse(@response.body)

    assert_response :success
    assert(result['boat_avail_prices'].length > 0)
    assert_equal true, result.has_key?('boat_avail_prices')
  end

	test "List All Available Boats Price"	do
		setup_request_default
		get :list
	    result = JSON.parse(@response.body)
		assert_response :success
		assert(result['boats'].length > 0)
		assert_equal true, result.has_key?('boats') 
	end
	
	test "List Available Boats Price For Specific Boat - Success"	do
		setup_request_default
		get :list, :boat_id => 1
	    result = JSON.parse(@response.body)
		assert_response :success
		assert(result['boat_avail_prices'].length > 0)
		assert_equal true, result.has_key?('boat_avail_prices')
	end

	test "List Available Boats Price For Specific Boat with Supplier GUID"	do
		setup_request_default
		get :list, :boat_guid => 'navigare_denis'
    	result = JSON.parse(@response.body)
		assert_response :success
		assert(result['boat_avail_prices'].length > 0)
		assert_equal true, result.has_key?('boat_avail_prices')
	end
	
	test "List Available Boats Price For Specific Boat - Failed with no match ID"	do
		setup_request_default
		get :list, :boat_id => 123
   		result = JSON.parse(@response.body)
		assert_response :success
		assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
	end
	
	test "Create Available Boats Price - Success" do
		setup_request_default
		boat1 = boats(:denis)
		data = {:boat_id => boat1.id, 
						:avail_boat => {
						:period_start => "2012-08-08", 
						:period_end => "2012-08-15", 
						:period_price => 2000, 
						:period_nights => 7,
						:calc => 'Base 2000'
						}
					}

		### check whether saved in or not
		assert_difference('BoatAvailPrice.count') do
			post :create, data

			### check the data from db
			last_data = BoatAvailPrice.last
      
  	  data[:avail_boat].keys.each do |column|
				value = last_data.send(column).is_a?(Date) ? last_data.send(column).to_s : last_data.send(column)
  	    assert_equal value, data[:avail_boat][column]
  	  end
		end

		 ### check response
		result = JSON.parse(@response.body)
		assert_response :success
		assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
  end

  test "create -- using boat_guid" do
    setup_request_default

    boat1 = boats(:denis)
    data = {:boat_guid => boat1.supplier_guid,
      :avail_boat => {
        :period_start => "2012-08-08",
        :period_end => "2012-08-15",
        :period_price => 2000,
        :period_nights => 7,
        :calc => 'Base 2000'
      }
    }

    ### check whether saved in or not
    assert_difference('BoatAvailPrice.count') do
      post :create, data

      ### check the data from db
      last_data = BoatAvailPrice.last

      data[:avail_boat].keys.each do |column|
        value = last_data.send(column).is_a?(Date) ? last_data.send(column).to_s : last_data.send(column)
        assert_equal value, data[:avail_boat][column]
      end
    end

    ### check response
    result = JSON.parse(@response.body)
    assert_response :success
    assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
  end

  test "create -- boat not found" do
    setup_request_default

    data = {
      :boat_id => -1,
      :avail_boat => {
        :period_start => "2012-08-08",
        :period_end => "2012-08-15",
        :period_price => 2000,
        :period_nights => 7,
        :calc => 'Base 2000'
      }
    }

    post :create, data

    result = JSON.parse(@response.body)
    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end

  test "create -- invalid boat avail price" do
    setup_request_default

    boat1 = boats(:denis)
    data = {
      :boat_id => boat1.id,
      :avail_boat => {
        :period_start => "2012-08-08",
        :period_end => "2012-08-15",
      }
    }

    post :create, data

    result = JSON.parse(@response.body)
    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end
	
	test "Update Available Boats Price Update All Fields - Success" do
		setup_request_default
		boat1 = boats(:denis)
		avail_boat1 = boat_avail_prices(:denis1)
		put :update, :id => avail_boat1.id, :avail_boat => DATA
		
		### make sure Available Boats Price is Updated
		avail_boat1.reload
		DATA.keys.each do |column|
			value = avail_boat1.send(column).is_a?(Date) ? avail_boat1.send(column).to_s : avail_boat1.send(column)
  	    		assert_equal value, DATA[column] 
  	  	end
		
		result = JSON.parse(@response.body)
		assert_response :success
		assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
  end

  test "update -- invalid boat price" do
    setup_request_default

    # invalid because date is the same as denis2
    data = {
      :period_start => "2012-07-08",
      :period_end => "2012-07-15",
      :period_price => 0,
      :period_nights => 0,
      :calc => 'Base 2000'
    }

    avail_boat1 = boat_avail_prices(:denis1)

    put :update, :id => avail_boat1.id, :avail_boat => data

    result = JSON.parse(@response.body)
    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end
	
	DATA.each do |key, value|
		test "Update Available Boats Price Update #{key.to_s.titleize} - Success" do
			setup_request_default
			avail_boat1 = boat_avail_prices(:denis1)
			put :update, :id => avail_boat1.id, :avail_boat => {key => value}
			result = JSON.parse(@response.body)
			assert_response :success
			assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
		end
		
		test "Update Available Boats Price Update #{key.to_s.titleize} - Failed" do
			assert_raise Exception do
				setup_request_default
				avail_boat1 = boat_avail_prices(:denis1)
				put :update, :id => 123, :avail_boat => {key => value}
				result = JSON.parse(@response.body)
			raise Exception
				assert_response :error
				assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
			end
		end
	end
	
	test "Delete Available Boats Price - Success" do
		setup_request_default
		avail_boat1 = boat_avail_prices(:denis1)
		### check whether deleted or not
		assert_difference('BoatAvailPrice.count', -1) do
			delete :destroy, :id => avail_boat1.id
		end
		result = JSON.parse(@response.body)
		assert_response :success
		assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
	end
	
	test "Delete Available Boats Price - Failed" do
		assert_raise Exception do
			setup_request_default
			avail_boat1 = boat_avail_prices(:denis1)
			assert_difference('BoatAvailPrice.count', 0) do
				delete :destroy, :id => 11111
			end
			result = JSON.parse(@response.body)
		raise Exception
			assert_response :success
			assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
		end
	end
		
end
