ActiveAdmin.register Addon do
	menu :label => 'Addon', :priority => 50, :parent => 'Merchandising'

	filter :name

	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |addon|
			link_to addon.name, admin_addon_path(addon)
		end
		column :per_booking_price
		column :per_night_price
		column :activated, :sortable => :activated
		default_actions
	end


	show :title => :name do

		attributes_table do
			row :id
			row :name
			row :per_booking_price
			row :per_night_price
			row :title_key
			row :description_key
			row :invoice_line_key
			row :activated
			row :created_at
			row :updated_at
		end
		
		active_admin_comments
	end

  
end
