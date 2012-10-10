ActiveAdmin.register Region do
	menu :label => 'Region', :priority => 50, :parent => 'Geography'

	filter :name

	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |region|
			link_to region.name, admin_region_path(region)
		end
		column :activated, :sortable => :activated
		default_actions
	end


	show :title => :name do

		attributes_table do
			row :id
			row :name
			row :activated
			row :created_at
			row :updated_at
		end

		panel "Marinas" do
			table_for region.marinas do
				column :name do |marina|
					link_to marina.name, admin_marina_path(marina)
				end
			end
		end
		
		active_admin_comments
	end

	sidebar "Status", :only => :show do
		status_tag (region.marinas.count > 0 ? "Marinas" : "No Marinas"), (region.marinas.count > 0 ? :ok : :error)
	end

	form do |f|
		f.inputs "Region" do
			f.input :name
			f.input :activated
		end

		f.inputs "Marinas" do
			f.input :marinas, :as => :check_boxes, :collection => Marina.order("name")
		end

  	f.buttons

	end  
  
end
