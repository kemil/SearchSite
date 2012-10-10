require 'test_helper'

class AddonTest < ActiveSupport::TestCase

	test "create default i18n keys" do
		i = Addon.new(:name => 'Great Skipper', :per_booking_price => 0, :per_night_price => 0)
		assert i.save
  	assert_equal "addon-greatskipper-title", i.title_key
  	assert_equal "addon-greatskipper-description", i.description_key
  	assert_equal "addon-greatskipper-invoice_line", i.invoice_line_key
	end

	test "get calculated price" do
		i1 = Addon.new(:name => 'test', :per_booking_price => 100, :per_night_price => 0)
		i2 = Addon.new(:name => 'test2', :per_booking_price => 0, :per_night_price => 1)
		i3 = Addon.new(:name => 'test3', :per_booking_price => 100, :per_night_price => 1)

		assert_equal 100, i1.price(Date.parse('2012-07-01'), Date.parse('2012-07-03'))
		assert_equal 2, i2.price(Date.parse('2012-07-01'), Date.parse('2012-07-03'))
		assert_equal 102, i3.price(Date.parse('2012-07-01'), Date.parse('2012-07-03'))
	end


end
