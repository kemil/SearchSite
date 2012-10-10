class Translation < ActiveRecord::Base
  
  validates_presence_of :locale, :key, :value
  validates_uniqueness_of :key
end
