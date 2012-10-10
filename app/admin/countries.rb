ActiveAdmin.register Country do
	menu :label => 'Country', :priority => 25, :parent => 'Geography'
	
	filter :name
	filter :isocode



	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |country|
			link_to country.name, admin_country_path(country)
		end
		column :isocode
		column :activated
		default_actions
	end



	show :title => :name do

		attributes_table do
			row :id
			row :name
			row :isocode
			row :activated
			row :created_at
			row :updated_at
		end

		panel "Marinas" do
			table_for country.marinas do
				column :name do |marina|
					link_to marina.name, admin_marina_path(marina)
				end
			end
		end

		panel "Supplier Marinas" do
			table_for country.supplier_marinas do
				column :name do |supplier_marina|
					link_to supplier_marina.name, admin_supplier_marina_path(supplier_marina)
				end
			end
		end
		
		active_admin_comments
	end


	sidebar "Status", :only => :show do
		status_tag (country.isocode != nil ? "ISO Code" : "No ISO Code"), (country.isocode != nil ? :ok : :error)
		status_tag (country.name.length > 2 ? "Name" : "Short name"), (country.name.length > 2 ? :ok : :error)
	end

  
end
