ActiveAdmin.register Customer do
	menu :label => 'Customers', :priority => 5, :parent => 'Fulfillment'

	filter :namefirst
	filter :namelast
	filter :email
	filter :address1
	filter :address2
	filter :zipcode
	filter :town
	filter :state
	filter :country
	filter :cellnumber
  
 	index do
		column :id, :sortable => :id
		column :namefirst, :sortable => :namefirst do |customer|
			link_to customer.namefirst, admin_customer_path(customer)
		end
		column :namelast, :sortable => :namelast do |customer|
			link_to customer.namelast, admin_customer_path(customer)
		end
		column :email
		column :country
		column :created_at
		default_actions
	end


	show :title => :to_s do
		attributes_table do
			[:id, :namefirst, :namelast, :address1, :address2, :zipcode, :town, :state, :country, :email, :cellnumber, :created_at, :updated_at].each do |column|
				row column
			end
		end

		panel "Trips" do
			table_for customer.trips do
				column :identifier do |trip|
					link_to trip.identifier, admin_trip_path(trip)
				end
				column :created_at
			end
		end
	end

	
end
