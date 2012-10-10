require 'test_helper'

class BoatTest < ActiveSupport::TestCase

  test "search by destination" do
    boats = Boat.search('ar')
    assert_equal(2, boats.size)

    boats = Boat.search('marina')
    assert_equal(2, boats.size)

    boats = Boat.search('marina1')
    assert_equal(1, boats.size)

    boats = Boat.search('croatia')
    assert_equal(1, boats.size)

    boats = Boat.search('Kastel Gomilica')
    assert_equal(2, boats.size)
    
    boats = Boat.search('Lik')
    assert_equal(0, boats.size)
  end

  test "search by period" do
    boats = Boat.search('marina', nil, Date.parse('2012-07-01'), Date.parse('2012-07-08'))
    assert_equal(1, boats.size)

    boats = Boat.search('marina', nil, Date.parse('2012-07-04'), Date.parse('2012-07-11'))
    assert_equal(0, boats.size)

    boats = Boat.search('marina', nil, Date.parse('2012-07-08'), Date.parse('2012-07-15'))
    assert_equal(1, boats.size)
  end

	test "rental period search starts before price period starts" do
		results = Boat.search_by_date('Marina1', Date.parse('2012-06-30'), Date.parse('2012-07-07'))
		assert_equal(0, results.size)
	end

	test "exact match of search period with price period" do
		results = Boat.search_by_date('Marina1', Date.parse('2012-07-01'), Date.parse('2012-07-08'))
		assert_equal(1, results.size)
		assert_equal(boat_avail_prices(:denis1).period_price, results.first.total_price)
	end

	test "price period ends before search period ends" do
		results = Boat.search_by_date('Marina1', Date.parse('2012-07-02'), Date.parse('2012-07-09'))
		assert_equal(0, results.size)
	end

	test "boat spaning two weeks and boat matching two periods, result sorted with lowest price first" do
    results = Boat.search_by_date('Marina', Date.parse('2012-07-08'), Date.parse('2012-07-22'))
    assert_equal(2, results.size)
    assert_equal(boat_avail_prices(:denis2).period_price + boat_avail_prices(:denis3).period_price, results.last.total_price)
    assert_equal(boat_avail_prices(:alice1).period_price, results.first.total_price)
	end

  test "newly created boat activated = false" do
    supplier1 = suppliers(:supplier1)
    principal1 = principals(:principal1)
    supplier_marina1 = supplier_marinas(:supplier_marina1)
    
    boat_params = {
      :supplier_guid => 'navigare_denis_new',
      :supplier_id => supplier1.id,
      :name => 'Rambo',
      :model_name => 'Bavaria 38 Cruiser',
      :model_year => 2009,
      :description => 'Yo ho ho ho, a pirate\'s life for me',
      :supplier_marina_id => supplier_marina1.id,
      :principal_id => principal1.id,
      :hull => 'mono',
      :length_ft => 38,
      :cabins => 3,
      :berths => 6,
      :heads => 1,
      :max_persons => 6,
      :fuel_capacity => 200,
      :water_capacity => 150
    }
    
    boat = Boat.new(boat_params)
    assert boat.save
    assert_equal(0, boat.activated)
  end
  
  test "casing of boat names" do
  	boat = boats(:badcase).dup
  	boat.supplier_guid = 'jsdkjhdfkjhdf'
  	
  	assert boat.save
  	assert_equal "My Name Is All Upper", boat.name
  	assert_equal "Unmatched Boat Model", boat.model_name
  end
  
  
  test "match a boat to boat_model" do
  	boat38c = boats(:denis)
  	boat38 = boats(:alice)
  
  	assert_equal boat_models(:bavaria38cruiser), boat38c.match_model
  	assert_equal boat_models(:bavaria38), boat38.match_model
  end

	test "boat's display name" do
  	boat38c = boats(:denis)
  	badcase = boats(:badcase)

		assert_equal "UNMATCHED BOAT MODEL", badcase.display_model
		assert_equal "Bavaria 38 Cruiser", boat38c.display_model
	end
	
	test "only show active boat while searching" do
    boats = Boat.search('')
    assert_not_equal(3, boats.size)
    assert_equal(2, boats.size)
  end
end
