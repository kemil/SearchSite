class BoatAttributeStandardValue < ActiveRecord::Base
	belongs_to :standard_attribute
	belongs_to :boat_attribute
end
