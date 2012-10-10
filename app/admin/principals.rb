ActiveAdmin.register Principal do
	menu :label => 'Principal', :priority => 100, :parent => 'Partners'

	filter :supplier
	filter :supplier_guid
    filter :name
  
 	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |principal|
			link_to principal.name, admin_principal_path(principal)
		end
		column :supplier
		column :supplier_guid
		default_actions
	end
 
  
end
