class BoatAttribute < ActiveRecord::Base
	belongs_to :boat
	has_one :boat_attribute_standard_value

  validates :description, :uniqueness => { :scope => :boat_id, :message => 'must be unique per boat'}
	
	# this baby get recursive due to callbacks is used in after_save and such
	def match_to_standard
		if self.boat_attribute_standard_value
			self.boat_attribute_standard_value.delete
		end 

		a = StandardAttributeMatch.all
		a.each do |attri|
			if self.description =~ /#{attri.matcher}/i
				sa = attri.standard_attribute
				basv = BoatAttributeStandardValue.create(:value => sa.standardize_value(self.value), :standard_attribute_id => sa.id, :boat_attribute_id => self.id)
				self.boat_attribute_standard_value = basv
				self.save

				break
			end
		end

	end
	
end
