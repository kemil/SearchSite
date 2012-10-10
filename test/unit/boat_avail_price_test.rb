require 'test_helper'

class BoatAvailPriceTest < ActiveSupport::TestCase
	DATA = {:boat_id => 1, :period_start => "2012-09-09", :period_end => "2012-09-16", :period_price => 5000, :period_nights => 7, :calc => "Baser price 5000"}
	test "Success Save With All fields valid" do
		boat_avail = boat_avail_prices(:denis1)
		assert_equal true, boat_avail.valid?
	end
	DATA.each_pair.each do |k, v|
		test "Failed Saving Without #{k.to_s}" do
			data = DATA.delete "#{k.to_s}"
			boat_avail = BoatAvailPrice.new data
			assert_equal false, boat_avail.valid?
		end
	end
	
end
