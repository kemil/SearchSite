class Principal < ActiveRecord::Base
  has_many :boats
  has_many :users
  belongs_to :supplier
  
  validates :name, :uniqueness => {:case_sensitive => false}, :presence => true
  validates :supplier_guid, :uniqueness => {:scope => :supplier_id, :message => 'must be unique per supplier'}
	
  # will likely expand with address, phone, email etc in later stage.
end
