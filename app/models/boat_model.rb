class BoatModel < ActiveRecord::Base
	has_many :boats
	has_many :boat_model_matches
  has_many :pictures, :as => :imageable
	
	accepts_nested_attributes_for :boat_model_matches, :pictures
end
