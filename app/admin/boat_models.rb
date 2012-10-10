ActiveAdmin.register BoatModel do
	menu :label => 'Models', :priority => 100, :parent => 'Yachts'
	
	filter :name

	index do
		column :id, :sortable => :id do |boat_model|
			link_to boat_model.id, admin_boat_model_path(boat_model)
		end
		column :name, :sortable => :name do |boat_model|
			link_to boat_model.name, admin_boat_model_path(boat_model)
		end
		default_actions
	end


	show :title => :name do

		attributes_table do
			[:description].each do |column|
				row column
			end
		end

		panel "Matchers" do
			table_for boat_model.boat_model_matches do
				column :matcher
			end
		end

		panel "Pictures" do
			table_for boat_model.pictures do
				column :url
				column :width
				column :height
				column :description
			end
		end
		
		panel "Boats" do
			table_for boat_model.boats do
				column :name do |boat|
					link_to boat.name, admin_boat_path(boat)
				end
			end
		end
		
		active_admin_comments
	end


	sidebar "Status", :only => :show do
		status_tag (boat_model.boat_model_matches.count > 0 ? "Matchers" : "Missing Matchers"), (boat_model.boat_model_matches.count > 0 ? :ok : :error)
		status_tag (boat_model.boats.count > 0 ? "Boats" : "No boats"), (boat_model.boats.count > 0 ? :ok : :error)
		status_tag (boat_model.pictures.count > 0 ? "Pictures" : "No pictures"), (boat_model.pictures.count > 0 ? :ok : :error)
	end


	form do |f|
		f.inputs "Boat Model" do
			f.input :name
		end

		f.has_many :boat_model_matches do |bmm|
			bmm.inputs "Matches" do
				bmm.input :matcher 
	    end
  	end
  	
  	f.has_many :pictures do |p|
  		p.inputs "Picture" do
  			p.input :url
  			p.input :width
  			p.input :height
  			p.input :description
  		end
  	end
  	
  	f.buttons

	end
  
end
