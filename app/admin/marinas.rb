ActiveAdmin.register Marina do
	menu :label => 'Marina', :priority => 50, :parent => 'Geography'

	scope :all

	scope :activated do |marina|
		marina.where("activated = 1")
	end

	scope :not_activated do |marina|
		marina.where("activated = 0")
	end

	filter :country
	filter :name

	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |marina|
			link_to marina.name, admin_marina_path(marina)
		end
		column :country
		column :activated
		default_actions
	end


	show :title => :name do

		attributes_table do
			row :id
			row :name
			row :latitude
			row :longitude
			row :address
			row :country
			row :activated
			row :created_at
			row :updated_at
		end

		panel "Supplier Marinas" do
			table_for marina.supplier_marinas do
				column :name do |supplier_marina|
					link_to supplier_marina.name, admin_supplier_marina_path(supplier_marina)
				end
			end
		end
		
		active_admin_comments
	end

	sidebar "Status", :only => :show do
		status_tag (marina.supplier_marinas.count > 0 ? "Supplier Marinas" : "No Supplier Marinas"), (marina.supplier_marinas.count > 0 ? :ok : :error)
		status_tag (marina.activated == 1  ? "Actiavted" : "Not activated"), (marina.activated == 1 ? :ok : :error)
	end

end
