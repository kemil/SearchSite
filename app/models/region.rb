class Region < ActiveRecord::Base
  has_and_belongs_to_many :marinas

	accepts_nested_attributes_for :marinas

  validates :name, :presence => true
end
