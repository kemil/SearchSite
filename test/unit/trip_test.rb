require 'test_helper'

class TripTest < ActiveSupport::TestCase

  test "identifier will be generated" do
    trip = Trip.new(:customer => customers(:johndoe))
    assert trip.save
    assert_not_nil trip
    assert_not_nil trip.identifier
  end
  
end
