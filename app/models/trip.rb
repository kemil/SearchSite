class Trip < ActiveRecord::Base
	has_many :invoices
	has_many :boat_reservations
	belongs_to :customer

  validates_presence_of :identifier, :customer
  validates_uniqueness_of :identifier

	before_validation :generate_identifier
	
	def generate_identifier
		self.identifier = [*('A'..'Z')].sample(8).join if self.new_record? and (self.identifier.nil? or self.identifier == '')
	end

	def to_s
		"#{identifier}"
	end

	def to_param
		"#{identifier}"
	end

	def fully_paid?
		invoices.each do |invoice|
			if !invoice.fully_paid?
				return false
			end
		end

		return true
	end

end
