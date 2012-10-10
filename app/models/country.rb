class Country < ActiveRecord::Base
  has_many :marinas
  has_many :supplier_marinas

  validates :name, :presence => true
  validates :isocode, :length => { :is => 2 }
  
  before_validation :uppercase_iso
  
  def uppercase_iso
  	if self.isocode == nil then self.isocode = 'XX' end
  	self.isocode = self.isocode.upcase
  end
  
  
  def self.options
    Country.all.map{|c|[c.name, c.id]}
  end
end
