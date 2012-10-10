class StandardAttribute < ActiveRecord::Base
	has_many :standard_attribute_matches
	has_many :boat_attribute_standard_value

	accepts_nested_attributes_for :standard_attribute_matches


	def standardize_value(val)
		if self.valuetype == 'boolean'
			val =~ /1|true|yes/i ? "true" : "false"
		elsif self.valuetype == 'integer'
			val.gsub(/[^0-9]/, "").to_i.to_s
		elsif self.valuetype == 'decimal'
			bd = BigDecimal.new(val.downcase.delete("a-z"), 2)
			bd.to_s
		else
			# eveything else just plain string
			val 
		end
	end
	
end
