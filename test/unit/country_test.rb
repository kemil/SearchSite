require 'test_helper'

class CountryTest < ActiveSupport::TestCase
	test "isocodes are uppercased" do
		c = Country.new(:name => 'America', :isocode => 'us')
		c.save
		c.reload
		assert_equal "US", c.isocode
	end
end
