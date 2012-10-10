class Addon < ActiveRecord::Base
	validates :name, :presence => true
	validates :per_booking_price, :presence => true
	validates :per_night_price, :presence => true

	before_save :generate_i18n_keys
	
	def generate_i18n_keys
		if self.new_record?

			base = name.downcase.gsub(/\W/, '')
			self.title_key = "addon-#{base}-title"
			self.description_key = "addon-#{base}-description"
			self.invoice_line_key = "addon-#{base}-invoice_line"
		end
	end

	def price(first_day, last_day)
		days = (last_day - first_day).to_i
		per_booking_price + (days * per_night_price)
	end

end
