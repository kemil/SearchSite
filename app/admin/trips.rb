ActiveAdmin.register Trip do
	menu :label => 'Trips', :priority => 50, :parent => 'Fulfillment'

	filter :customer
	filter :identifier
	filter :created_at

  controller do
  	defaults :finder => :find_by_identifier
  end
  
 	index do
		column :id, :sortable => :id
		column :identifier, :sortable => :identifier do |trip|
			link_to trip.identifier, admin_trip_path(trip)
		end
		column :created_at
		default_actions
	end

	show :title => :identifier do
		attributes_table do
			[:id, :customer, :identifier, :created_at, :updated_at].each do |column|
				row column
			end
		end

		panel "Invoices" do
			table_for trip.invoices do
				column :identifier do |invoice|
					link_to invoice.identifier, admin_invoice_path(invoice)
				end
				column :currency
				column :status
				column :created_at
			end
		end
		
		panel "Reservations" do
			table_for trip.boat_reservations do
				column :id do |res|
					link_to res.id, admin_boat_reservation_path(res)
				end
				column :boat
				column :status
				column :externalref
				column :rentaltimestart
				column :rentaltimeend
				#column :rentalmarinastart
				#column :rentalmarinaend
				column :created_at
			end
		end
		
		# we should use our own comments system for this!
		# active_admin_comments
	end


#	sidebar "Status", :only => :show do
#		status_tag (boat_model.boat_model_matches.count > 0 ? "Matchers" : "Missing Matchers"), (boat_model.boat_model_matches.count > 0 ? :ok : :error)
#		status_tag (boat_model.boats.count > 0 ? "Boats" : "No boats"), (boat_model.boats.count > 0 ? :ok : :error)
#	end

	form do |f|
		f.inputs "Trip" do
			f.input :customer
		end
  	
  	f.buttons

	end
  
end
