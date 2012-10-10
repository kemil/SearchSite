ActiveAdmin.register Supplier do
	menu :label => 'Supplier', :priority => 100, :parent => 'System'
  
  filter :name
  
 	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |supplier|
			link_to supplier.name, admin_supplier_path(supplier)
		end
		default_actions
	end
 
  
end
