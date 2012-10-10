class InvoiceLine < ActiveRecord::Base
	belongs_to :invoice
	
	before_save :save_due_total
	after_save :save_invoice_total
	
	default_scope order("id ASC")

	def save_due_total
		self.duetotal = duecount * (dueamount + duevat)
	end

	def save_invoice_total
		self.invoice.save
	end

end
