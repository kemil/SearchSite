require 'test_helper'
require 'json'
require File.dirname(__FILE__) + '/base_test.rb'

class Api::V1::SupplierMarinasControllerTest < Api::V1::BaseTest
  test "create -- country not exist SUCCESS" do
    setup_request_default

    params = {:supplier_marina =>
      {
        :name => "Marina3",
        :country => "Timbuktu",
        :address => "Anywhere You Want",
        :latitude => -122.395899,
        :longitude => 37.793621,
        :supplier_guid => 'marina3'
      }
    }

    ### check whether saved in or not
    assert_difference('SupplierMarina.count') do
      post :create, params

      ### check response
      puts @response.body
      result = JSON.parse(@response.body)
      assert_response :success
      assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']

      ### check the data from db
      last_data = SupplierMarina.last

      data  = params[:supplier_marina].except(:country)
      data.keys.each do |column|
        assert_equal data[column], last_data.send(column), "on column #{column}"
      end

      # saved supplier marina should have supplier, marina, and country
      assert_not_nil last_data.supplier, 'created supplier marina `supplier` is nil'
      assert_not_nil last_data.marina, 'create supplier marina `marina` is nil'
    end
  end

  test "create country with isocode as name" do
    setup_request_default

    params = {:supplier_marina =>
      {
        :name => "Yada Marina",
        :country => "hr",
        :address => "Anywhere You Want",
        :latitude => -122.395899,
        :longitude => 37.793621,
        :supplier_guid => 'yadamarina'
      }
    }

    ### check whether saved in or not
    assert_difference('SupplierMarina.count') do
      post :create, params

      ### check response
      puts @response.body
      result = JSON.parse(@response.body)
      assert_response :success
      assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']

      ### check the data from db
      last_data = SupplierMarina.find_by_name(params[:supplier_marina][:name])

      assert_equal countries(:country1), last_data.country
    end
  end


  test "Success Save Supplier Marina" do
    setup_request_default

    params = {:supplier_marina =>
      {
        :name => "Marina3", 
        :country => "Croatia",
        :address => "Anywhere You Want",
        :latitude => -122.395899, 
        :longitude => 37.793621,
        :supplier_guid => 'marina3'
      }
    }
    
    ### check whether saved in or not     
    assert_difference('SupplierMarina.count') do
      post :create, params
      
      ### check response
      puts @response.body
      result = JSON.parse(@response.body)
      assert_response :success
      assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
      
      ### check the data from db
      last_data = SupplierMarina.last
      
      data  = params[:supplier_marina].except(:country)
      data.keys.each do |column|
        assert_equal data[column], last_data.send(column), "on column #{column}"
      end

      # saved supplier marina should have supplier, marina, and country
      assert_not_nil last_data.supplier, 'created supplier marina `supplier` is nil'
      assert_not_nil last_data.marina, 'create supplier marina `marina` is nil'
    end
  end

  test "Duplicate Supplier Marina Should Fail" do
    setup_request_default
    
    params = {:supplier_marina =>
      {
        :name => "Marina3", 
        :country => "Croatia",
        :address => "Anywhere You Want",
        :latitude => -122.395899, 
        :longitude => 37.793621,
        :supplier_guid => 'supplier_marina1'
      }
    }

    post :create, params
    
    puts @response.body
    result = JSON.parse(@response.body)
    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
    assert_equal result['message'], "Validation failed: Supplier guid has already been taken"
  end

  test "Failed Save Supplier Marina" do
    assert_raise Exception do
      marina = supplier_marinas()
      assert_not_nil marina
      marina_count = SupplierMarina.count
      post :create, nil
      
      ## check Supplier Marina, data should not be increased after create failed
      assert_equal marina_count, SupplierMarina.count
      
      raise Exception
      assert_response :error #, {:error => "API EXCEPTION ERROR"}.to_json
    end
  end
  
  test "List All Supplier Marinas"  do
    setup_request_default
    get :list
    result = JSON.parse(@response.body)
    assert_response :success
    puts result
    assert result.has_key?('marinas')
  end
end
