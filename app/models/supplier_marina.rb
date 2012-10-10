class SupplierMarina < ActiveRecord::Base
  belongs_to :marina
  belongs_to :country
  belongs_to :supplier

  attr_accessor :activated

  validates :supplier_guid, :uniqueness => true, :presence => true

end
