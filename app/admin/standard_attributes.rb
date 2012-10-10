ActiveAdmin.register StandardAttribute do
	menu :label => 'Standard Attributes', :priority => 100, :parent => 'Yachts'

	filter :description
	filter :valuetype, :as => :select, :collection => ["string", "integer", "boolean", "decimal"]

	index do
		column :id
		column :description, :sortable => :description do |sa|
			link_to sa.description, admin_standard_attribute_path(sa)
		end
		column :valuetype
		default_actions
	end


	show :title => :description do
		panel "Matchers" do
			table_for standard_attribute.standard_attribute_matches do
				column :matcher
			end
		end

		active_admin_comments
	end


	sidebar "Status", :only => :show do
		status_tag (standard_attribute.standard_attribute_matches.count > 0 ? "Matchers" : "Missing Matchers"), (standard_attribute.standard_attribute_matches.count > 0 ? :ok : :error)
	end


	form do |f|
		f.inputs "Standard Attribute" do
			f.input :description
			f.input :valuetype, :as => :select, :collection => ["string", "integer", "boolean", "decimal"]
		end

		f.has_many :standard_attribute_matches do |sam|
			sam.inputs "Matches" do
				sam.input :matcher 
			end
  	end
  	
  	f.buttons

	end
  
end
