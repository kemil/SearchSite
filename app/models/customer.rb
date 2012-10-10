class Customer < ActiveRecord::Base
	has_many :trips
	belongs_to :country
	
	#validations
	  validates :namefirst, :namelast, :address1, :zipcode, :town, :state, :country_id, :email, :cellnumber, :presence => true
	def to_s
		"#{namefirst} #{namelast}"
	end
end
