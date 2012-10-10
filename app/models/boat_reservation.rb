class BoatReservation < ActiveRecord::Base
	belongs_to :trip
	belongs_to :boat
	
	belongs_to :rentalmarinastart, :class_name => "SupplierMarina"
	belongs_to :rentalmarinaend, :class_name => "SupplierMarina"

	STATUS = {
		:new => 0,
		:confirmed => 1,
		:denied => 201, # all codes where not available should be 
	}

	validates_inclusion_of :status, :in => STATUS.values
	validates :externalref, :format => {:with => /\A[a-zA-Z0-9\-]*\z/, :message => 'Only A-Z, digits and -'}

	scope :past, lambda { where("rentaltimeend < ?", Time.now) }
	scope :upcoming, lambda { where("rentaltimestart > ?", Time.now) }
end
