ActiveAdmin.register Invoice do
	menu :label => 'Invoices', :priority => 75, :parent => 'Fulfillment'

	filter :identifier
	filter :status
	filter :created_at

	index do
		column :id
		column :trip
		column :identifier, :sortable => :identifier do |invoice|
			link_to invoice.identifier, admin_invoice_path(invoice)
		end
		column :currency
		column :status
		default_actions
	end


	show :title => :identifier do
		attributes_table do
			[:id, :trip, :identifier, :currency, :status, :due_amount, :created_at, :updated_at].each do |column|
				row column
			end
		end

		panel "Invoice Lines" do
			table_for invoice.invoice_lines do
				column :description
				column :duecount
				column :dueamount
				column :duevat
				column :duetotal
				column :created_at
				column :updated_at
			end
		end

		panel "Payments" do
			table_for invoice.payments do
				column :id
				column :psp
				column :externalref
				column :amount
				column :currency
				column :created_at
				column :updated_at
			end
		end
		
		# should use our own
		#active_admin_comments
	end


#	sidebar "Status", :only => :show do
#		status_tag (boat_model.boat_model_matches.count > 0 ? "Matchers" : "Missing Matchers"), (boat_model.boat_model_matches.count > 0 ? :ok : :error)
#		status_tag (boat_model.boats.count > 0 ? "Boats" : "No boats"), (boat_model.boats.count > 0 ? :ok : :error)
#	end


	form do |f|
		f.inputs "Invoice" do
			f.input :trip
			f.input :currency, :as => :select, :collection => ['EUR']
			f.input :status, :as => :select, :collection => Invoice::STATUS, :include_blank => false
		end

		f.has_many :invoice_lines do |il|
			il.inputs "Invoice Line" do
				il.input :description
				il.input :duecount
				il.input :dueamount
				il.input :duevat
	    end
  	end

		f.has_many :payments do |p|
			p.inputs "Payments" do
				p.input :psp, :as => :select, :collection => ['dibs']
				p.input :externalref
				p.input :amount
				p.input :currency, :as => :select, :collection => ['EUR']
	    end
  	end
  	
  	f.buttons

	end
  
end
