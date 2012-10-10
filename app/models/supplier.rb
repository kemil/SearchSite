require 'digest/md5'

class Supplier < ActiveRecord::Base
  has_many :supplier_marinas
  has_many :principals
  has_many :marinas, :through => :supplier_marinas

  validates :name, :uniqueness => true, :presence => true
  
  before_create do |supplier|
    supplier.generate_access_token! if supplier.access_token == nil or supplier.access_token == ''
  end
    
  def self.find_by_access_token(access_token)
    return Supplier.where(['access_token = ?', access_token]).first
  end
  
  def generate_access_token!
    salt = 'yachtzee'
    token = self.name + ':' + salt + ':' + Time.now.to_f.to_s
    self.access_token = Digest::MD5.hexdigest( token )
  end
end
