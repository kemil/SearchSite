ActiveAdmin.register BoatAvailPrice do
	menu :label => 'Boat Avail Prices', :priority => 51, :parent => 'Yachts'
  
  filter :boat
  filter :period_start
  filter :period_end
  filter :period_nights
  filter :period_price

	index do
		column :id do |boat_avail_price|
			link_to boat_avail_price.id, admin_boat_avail_price_path(boat_avail_price)
		end
		column :period_start
		column :period_end
		column :period_nights
		column :period_price
		column :boat
		default_actions
	end
  
end
