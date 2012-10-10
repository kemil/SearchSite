require 'test_helper'
require 'json'

require File.dirname(__FILE__) + '/base_test.rb'

class Api::V1::BoatsControllerTest < Api::V1::BaseTest
  test "create boat" do
    setup_request_default
    
    supplier1 = suppliers(:supplier1)
    principal1 = principals(:principal1)
    supplier_marina1 = supplier_marinas(:supplier_marina1)
    
    params = {:boat =>
      {
        :supplier_guid => 'navigare_denis_nondupe',
        :supplier_id => supplier1.id,
        :name => 'Rambo',
        :model_name => 'Bavaria 38 Cruiser',
        :model_year => 2009,
        :description => 'Yo ho ho ho, a pirate\'s life for me',
        :hull => 'mono',
        :length_ft => 38,
        :cabins => 3,
        :berths => 6,
        :heads => 1,
        :max_persons => 6,
        :fuel_capacity => 200,
        :water_capacity => 150
      },
      :principal_guid => principal1.supplier_guid,
      :supplier_marina_guid => supplier_marina1.supplier_guid
    }

    post :create, params
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
  end

  test "create -- invalid boat" do
    setup_request_default

    supplier1 = suppliers(:supplier1)
    principal1 = principals(:principal1)
    supplier_marina1 = supplier_marinas(:supplier_marina1)

    params = {:boat =>
      {
        :supplier_guid => 'navigare_denis_nondupe',
        :supplier_id => supplier1.id,
        #:name => 'Rambo',
        :model_name => 'Bavaria 38 Cruiser',
        :model_year => 2009,
        :description => 'Yo ho ho ho, a pirate\'s life for me',
        :hull => 'mono',
        :length_ft => 38,
        :cabins => 3,
        :berths => 6,
        :heads => 1,
        :max_persons => 6,
        :fuel_capacity => 200,
        :water_capacity => 150
      },
      :principal_guid => principal1.supplier_guid,
      :supplier_marina_guid => supplier_marina1.supplier_guid
    }

    post :create, params

    result = JSON.parse(@response.body)

    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end

  test "create -- no principal_guid" do
    setup_request_default

    supplier1 = suppliers(:supplier1)
    principal1 = principals(:principal1)
    supplier_marina1 = supplier_marinas(:supplier_marina1)

    params = {:boat =>
      {
          :supplier_guid => 'navigare_denis_nondupe',
          :supplier_id => supplier1.id,
          :name => 'Rambo',
          :model_name => 'Bavaria 38 Cruiser',
          :model_year => 2009,
          :description => 'Yo ho ho ho, a pirate\'s life for me',
          :hull => 'mono',
          :length_ft => 38,
          :cabins => 3,
          :berths => 6,
          :heads => 1,
          :max_persons => 6,
          :fuel_capacity => 200,
          :water_capacity => 150
      },
      :supplier_marina_guid => supplier_marina1.supplier_guid
    }

    post :create, params

    result = JSON.parse(@response.body)

    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end

  test "create -- no supplier_marina_guid" do
    setup_request_default

    supplier1 = suppliers(:supplier1)
    principal1 = principals(:principal1)
    supplier_marina1 = supplier_marinas(:supplier_marina1)

    params = {:boat =>
                  {
                      :supplier_guid => 'navigare_denis_nondupe',
                      :supplier_id => supplier1.id,
                      :name => 'Rambo',
                      :model_name => 'Bavaria 38 Cruiser',
                      :model_year => 2009,
                      :description => 'Yo ho ho ho, a pirate\'s life for me',
                      :hull => 'mono',
                      :length_ft => 38,
                      :cabins => 3,
                      :berths => 6,
                      :heads => 1,
                      :max_persons => 6,
                      :fuel_capacity => 200,
                      :water_capacity => 150
                  },
              :principal_guid => principal1.supplier_guid
    }

    post :create, params

    result = JSON.parse(@response.body)

    assert_response :success
    assert_equal Api::V1::ApiCode::BAD_REQUEST[:code], result['code']
  end

  test "create boat without length ft should success" do
    setup_request_default
    
    supplier1 = suppliers(:supplier1)
    principal1 = principals(:principal1)
    supplier_marina1 = supplier_marinas(:supplier_marina1)
    
    params = {:boat =>
      {
        :supplier_guid => 'navigare_denis_nondupe',
        :supplier_id => supplier1.id,
        :name => 'Rambo',
        :model_name => 'Bavaria 38 Cruiser',
        :model_year => 2009,
        :description => 'Yo ho ho ho, a pirate\'s life for me',
        :hull => 'mono',
        :cabins => 3,
        :berths => 6,
        :heads => 1,
        :max_persons => 6,
        :fuel_capacity => 200,
        :water_capacity => 150
      },
      :principal_guid => principal1.supplier_guid,
      :supplier_marina_guid => supplier_marina1.supplier_guid
    }

    post :create, params
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_equal Api::V1::ApiCode::SUCCESS[:code], result['code']
  end
  
  test "list boat by supplier_guid" do
    setup_request_default
    
    get :list, {:boat_guid => 'navigare_denis'}
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_not_nil assigns(:boats)
    assert_equal result['boats'][0]['name'], 'Denis'
    
    boats = Boat.where(:supplier_guid => 'navigare_denis')
    compare_boat_results(boats, result['boats'])
  end
  
  test "list boat by principal supplier_guid" do
    setup_request_default
    
    principal1 = principals(:principal1)
    
    get :list, {:principal_guid => principal1.supplier_guid}
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_not_nil assigns(:boats)
    
    ### test boat results
    current_supplier = suppliers(:supplier1)
    boats = Boat.where("principal_id = ? AND supplier_id = ?",
                       principal1.id, current_supplier.id)
    compare_boat_results(boats, result['boats'])
  end
  
  test "list boat without parameter" do
    setup_request_default
    
    get :list
    
    result = JSON.parse(@response.body)
    
    assert_response :success
    assert_not_nil assigns(:boats)
    
    ### test boat results
    current_supplier = suppliers(:supplier1)
    boats = Boat.where(:supplier_id => current_supplier.id)
    compare_boat_results(boats, result['boats'])
  end
  
  private

  # result_boats should match boats
  def compare_boat_results(boats, result_boats)
    assert(result_boats.length == boats.length)
    
    # generate boat_ids
    boat_ids = []
    boats.each { |boat| boat_ids.push(boat.id) }
    
    # generate boat ids gotten from api call
    result_boat_ids = []
    result_boats.each { |boat| result_boat_ids.push(boat['id']) }
    
    assert (result_boat_ids.sort == boat_ids.sort)
  end
end
