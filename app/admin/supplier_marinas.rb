ActiveAdmin.register SupplierMarina do
	menu :label => 'Supplier Marina', :priority => 100, :parent => 'Geography'

	filter :marina
	filter :country
	filter :name
	filter :supplier_guid

	index do
		column :id, :sortable => :id
		column :name, :sortable => :name do |supplier_marina|
			link_to supplier_marina.name, admin_supplier_marina_path(supplier_marina)
		end
		column :marina, :sortable => :marina do |supplier_marina|
			link_to supplier_marina.marina.name, admin_marina_path(supplier_marina.marina)
		end
		column :country
		default_actions
	end
  
end
