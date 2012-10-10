require 'test_helper'

class YachtSearchControllerTest < ActionController::TestCase

  test "search -- everything specified" do
    get :search, :destination => 'marina', :people => 1, :pickup => '2012-07-01', :return => '2012-07-08'
    assert_response :success
    assert_not_nil assigns(:available)
    assert_equal 1, assigns(:available).length

    bap = assigns(:available)[0]
    assert_equal 'Denis', bap.name
    assert_equal 7000, bap.total_price
  end

  test "search -- only destination specified" do
    get :search, :destination => 'marina1'
    assert_response :success
    assert_not_nil assigns(:available)
    assert_equal 1, assigns(:available).length

    bap = assigns(:available)[0]
    assert_equal 'Denis', bap.name
    assert_equal 7000, bap.total_price
  end
  
  test "search -- with region" do
    get :search, :destination => 'Kastel Gomilica'
    assert_response :success
    assert_not_nil assigns(:available)
    assert_equal 2, assigns(:available).length

    bap = assigns(:available)[0]
    assert_equal 'Denis', bap.name
    assert_equal 7000, bap.total_price
    
    bap2 = assigns(:available)[1]
    assert_equal 'Alice', bap2.name
    assert_equal 10000, bap2.total_price
  end

  test "search -- invalid people" do
    get :search, :destination => 'marina2', :people => 'aldfjal'
    assert_response :success
    assert_not_nil assigns(:available)
    assert_equal 1, assigns(:available).length

    bap = assigns(:available)[0]
    assert_equal 'Alice', bap.name
    assert_equal 10000, bap.total_price
  end

  test "search_proxy -- basic" do
    get :search_proxy, :destination => 'a', :people => 1, :pickup => '2012-10-13', :return => '2012-10-20'
    assert_redirected_to(:controller => 'yacht_search', :action => 'search',
                         :destination => 'a', :people => 1, :pickup => '2012-10-13', :return => '2012-10-20')
  end

  test "search proxy -- blank destination" do
    get :search_proxy, :destination => '', :people => 1, :pickup => '2012-10-13', :return => '2012-10-20'
    assert_redirected_to(:controller => 'yacht_search', :action => 'search',
                         :destination => '+', :people => 1, :pickup => '2012-10-13', :return => '2012-10-20')
  end
end
