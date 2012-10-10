class Invoice < ActiveRecord::Base
	belongs_to :trip
	has_many :invoice_lines
	has_many :payments

	accepts_nested_attributes_for :invoice_lines, :payments, :allow_destroy => true

	STATUS = {
		:new => 0,
		:paid_full => 1,
		:paid_partial => 2,
	}

  validates_presence_of :identifier, :trip, :currency, :status
  validates_uniqueness_of :identifier

	before_validation :generate_things
	before_save :save_due_amount
	
	def save_due_amount
		invoice_lines.each do |invline| # due_amount calc below will get nil exception otherwise
			invline.save_due_total
		end

		self.due_amount = self.invoice_lines.map(&:duetotal).sum
	end
	
	def generate_things
		self.identifier = self.trip.identifier + "-" + (self.trip.invoices.count+1).to_s if self.new_record? and (self.identifier.nil? or self.identifier == '')
		self.status = 0 if self.new_record? and self.status.nil?
		self.currency = 'EUR' if self.new_record? and (self.currency.nil? or self.currency == '')
	end

	def amount_paid
		self.payments.map(&:amount).sum
	end

	def fully_paid?
		status == Invoice::STATUS[:paid_full]
	end

end
