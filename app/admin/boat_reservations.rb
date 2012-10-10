ActiveAdmin.register BoatReservation do
	menu :label => 'Reservations', :priority => 100, :parent => 'Fulfillment'

	filter :boat
	filter :externalref
	filter :status
	filter :rentalmarinastart
	filter :rentaltimestart
	filter :rentaltimeend
	filter :created_at

	index do
		column :id, :sortable => :id do |res|
			link_to res.id, admin_boat_reservation_path(res)
		end
		column :externalref
		column :status
		column :rentalmarinastart
		column :rentaltimestart
		column :rentaltimeend
		column :boat
		default_actions
	end


	show :title => :id do
		attributes_table do
			[:id, :trip, :boat, :status, :externalref, :rentaltimestart, :rentaltimeend, :rentalmarinastart, :rentalmarinaend, :created_at, :updated_at].each do |column|
				row column
			end
		end
		
		# should use our own
		#active_admin_comments
	end


#	sidebar "Status", :only => :show do
#		status_tag (boat_model.boat_model_matches.count > 0 ? "Matchers" : "Missing Matchers"), (boat_model.boat_model_matches.count > 0 ? :ok : :error)
#		status_tag (boat_model.boats.count > 0 ? "Boats" : "No boats"), (boat_model.boats.count > 0 ? :ok : :error)
#	end


	form do |f|
		f.inputs "Reservation" do
			f.input :trip
			f.input :boat
			f.input :status, :as => :select, :collection => BoatReservation::STATUS
			f.input :externalref
			f.input :rentaltimestart
			f.input :rentaltimeend
			f.input :rentalmarinastart
			f.input :rentalmarinaend
		end

  	f.buttons

	end
  

  
end
