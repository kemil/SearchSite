ActiveAdmin.register Boat do
	menu :label => 'Boats', :priority => 50, :parent => 'Yachts'

	scope :all

	scope :activated do |boat|
		boat.where("activated = 1")
	end

	scope :not_activated do |boat|
		boat.where("activated = 0")
	end

	scope :no_model do |boat|
		boat.where("boat_model_id IS NULL")
	end

	filter :name
	filter :supplier_marina, :collection => proc { SupplierMarina.order("name") }
	filter :principal
	filter :model_name
	filter :boat_model
	filter :supplier_guid

  controller do
  	defaults :finder => :find_by_permalink
  end
    
	index do
		column :id
		column :name do |boat|
			link_to boat.name, admin_boat_path(boat)
		end
		column :supplier_marina
		column :principal
		column :boat_model
		column :activated
		default_actions
	end


	member_action :rematch, :method => :get do
		boat = Boat.find_by_permalink(params[:id])
		if boat != nil
			boat.save # will trigger re-matching that happens on save
			flash[:notice] = "Re-matched boat to model!"
	    redirect_to :action => :show
	  else
			flash[:notice] = "Couldn't find that boat!"
	    redirect_to :action => :index
	  end
  end
    
	action_item only:[:show] do
		link_to "Re-match", rematch_admin_boat_path(boat)
	end
 

	show :title => :name do
		attributes_table do
			[:id, :name, :supplier_guid, :supplier, :model_name, :model_year, :description, :supplier_marina, :principal, :boat_model, :activated, :permalink, :created_at, :updated_at].each do |column|
				row column
			end
		end

		attributes_table do
			[:hull, :length_ft, :cabins, :berths, :heads, :max_persons, :fuel_capacity, :water_capacity].each do |column|
				row column
			end
		end

		panel "Pictures" do
			table_for boat.pictures do
				column :url
				column :width
				column :height
				column :description
			end
		end
		
		panel "Standard Attributes" do
			table_for boat.boat_attribute_standard_values do
				column :standard_attribute do |basv|
					link_to basv.standard_attribute.description, admin_standard_attribute_path(basv.standard_attribute)
				end
				column :value
				column :boat_attribute do |basv|
					basv.boat_attribute.description + " (" + basv.boat_attribute.value  + ")"
				end
			end
		end

		panel "Boat Attributes" do
			table_for boat.boat_attributes do
				column :description
				column :value
			end
		end

		panel "Prices" do
			table_for boat.boat_avail_prices do
				column :period_start
				column :period_end
				column :period_price
				column :period_nights
			end
		end

		
		active_admin_comments
	end

	sidebar "Status", :only => :show do
		status_tag (boat.activated == 1 ? "Active" : "Not Active"), (boat.activated == 1 ? :ok : :error)
		status_tag (boat.boat_model != nil ? "Model" : "No Model"), (boat.boat_model != nil ? :ok : :error)
	end


	form do |f|
		f.inputs "Boat" do
			f.input :name
			f.input :supplier_guid
			f.input :supplier
			f.input :model_name
			f.input :model_year
			f.input :description
			f.input :supplier_marina
			f.input :principal
			f.input :boat_model
			f.input :activated
			f.input :permalink
			f.input :hull, :as => :select, :collection => ['mono']
			f.input :length_ft
			f.input :cabins
			f.input :berths
			f.input :heads
			f.input :max_persons
			f.input :fuel_capacity
			f.input :water_capacity
		end

		f.has_many :pictures do |p|
			p.inputs "Picture" do
				p.input :url
				p.input :width
				p.input :height
				p.input :description
			end
		end

		f.has_many :boat_attributes do |ba|
			ba.inputs "Boat Attribute" do
				ba.input :description
				ba.input :value
	    end
  	end
  	
  	f.buttons

	end

  
end
