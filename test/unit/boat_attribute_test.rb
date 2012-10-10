require 'test_helper'

class BoatAttributeTest < ActiveSupport::TestCase

  test "match to standard attribute" do
    ba = BoatAttribute.create(:description => 'GPS Navigation', :value => 'true', :boat_id => 1)
    ba.match_to_standard
    gps = standard_attributes(:gps)
    assert_equal gps, ba.boat_attribute_standard_value.standard_attribute
  end

end
