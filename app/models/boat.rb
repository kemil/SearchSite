class Boat < ActiveRecord::Base
  include Util
  has_permalink :show_boat

  has_many :boat_avail_prices
  has_many :pictures, :as => :imageable
  has_many :boat_attributes
  has_many :boat_attribute_standard_values, :through => :boat_attributes
  belongs_to :supplier_marina
  #belongs_to :marina, :through => :supplier_marina
  belongs_to :principal
  belongs_to :supplier
  belongs_to :boat_model

	accepts_nested_attributes_for :boat_attributes, :pictures
  
  attr_accessor :total_price
  
  # validations
  validates :name, :presence => true
  validates :supplier_id, :presence => true
  validates :principal_id, :presence => true
  validates :supplier_marina_id, :presence => true
  
  #validates :length_ft, :numericality => { :greater_than => 0 }
  #validates :cabins, :numericality => { :greater_than => 0 }
  #validates :max_persons, :numericality => { :greater_than => 0 }
  #validates :fuel_capacity, :numericality => { :greater_than => 0 }
  #validates :water_capacity, :numericality => { :greater_than => 0 }
  
  validates :supplier_guid, :uniqueness => { :scope => :supplier_id, :message => 'must be unique per supplier'}

  before_save :nice_case_names
  before_save :validates_format_of_supplier_guid
  before_save :save_model

  class << self
    ###
    # Search boats
    #
    # @param [String] destination
    # @param [Fixnum] people
    # @param [Date] pickup_date
    # @param [Date] return_date
    # @param [Fixnum] limit -- (TODO: NOT IMPLEMENTED)
    # @return -- list of boats with price
    ###
    def search(destination, people=nil, pickup_date=nil, return_date=nil, limit=nil)
      if pickup_date.nil? or return_date.nil?
        return self.search_by_destination(destination, people, limit)
      else
        return self.search_by_date(destination, pickup_date, return_date, people, limit)
      end
    end

    def search_by_destination(destination, people=nil, limit=nil)
      destination = destination.downcase
      invalid_destination = Boat.set_valid_destination(destination)
      @boats = []
      
      unless invalid_destination == [true, true, true] && !destination.blank?
        q = Boat.joins(:supplier_marina)
        q = q.joins('INNER JOIN marinas ON marinas.id = supplier_marinas.marina_id')
        q = q.joins('INNER JOIN countries ON countries.id = supplier_marinas.country_id') if !destination.blank? && invalid_destination[1] == false
        if !destination.blank? && invalid_destination[2] == false
          q = q.joins('INNER JOIN marinas_regions ON marinas_regions.marina_id = marinas.id')
          q = q.joins('INNER JOIN regions ON regions.id = marinas_regions.region_id')
        end

        q = Boat.set_destination_condition(q, destination, invalid_destination)
        q = q.where('berths >= ?', people) if !people.nil?
        q = q.where('boats.activated != 0')
        q = q.group('boats.id')

        q.each do |boat|
          avail_price = BoatAvailPrice.where('boat_id = ?', boat.id).first

          next if avail_price.nil?

          boat.total_price = avail_price.period_price
          @boats.push(boat)
        end
      end

      return @boats
    end

    def search_by_date(destination, pickup_date, return_date, people=nil, limit=nil)
      destination = destination.downcase
require 'pp'
      @boats = []
      avail_prices = BoatAvailPrice.find_period(pickup_date, return_date)
      pp avail_prices
      avail_prices.each do |bap|
        b = Boat.find_by_id(bap.boat_id)

        next if !people.nil? and people > b.berths
        type = Boat.set_valid_destination(destination)

        if type == [true, true, true] && !destination.blank?
          next
        elsif type[0] == false
          next if b.supplier_marina.marina.name.downcase.index(destination).nil?
        elsif type[1] == false
          next if b.supplier_marina.marina.country.name.downcase.index(destination).nil?
        elsif type[2] == false
          next if !b.supplier_marina.marina.regions.map{|x| x.name.downcase}.include?(destination)
        end

        b.total_price = bap.total_price.to_i
        @boats.push(b) if b.activated != 0
      end

      @boats.sort! {|a,b| a.total_price <=> b.total_price}
      return @boats
    end
  end

  def show_boat
    "#{self.id} #{self.name} #{self.model_name}"
  end

	def display_model
		self.boat_model != nil ? boat_model.name : self.model_name
	end

  def display_description
    self.description.blank? ? boat_model.description : description
  end

  def display_pictures
    self.boat_model != nil ? boat_model.pictures + pictures : pictures
  end

	def match_model
    matched = nil

		BoatModelMatch.select("*, length(matcher) as L").order("L desc").each do |ma|
			if self.model_name =~ /#{ma.matcher}/i
        # puts "MATCHED! #{ma.matcher} with model #{ma.boat_model.name}"
        matched = ma.boat_model
        break
      end
		end
		
		matched
	end
	
	def save_model
		if self.boat_model == nil 
      mo = self.match_model
      if mo != nil
        self.boat_model_id = mo.id
      end
    end
	end

  def self.set_valid_destination(destination)
    type = []
    type << Marina.first(:conditions => "name ILIKE '%#{destination}%' AND activated != 0").blank?
    type << Country.first(:conditions => "name ILIKE '%#{destination}%' AND activated != 0").blank?
    type << Region.first(:conditions => "name ILIKE '%#{destination}%' AND activated != 0").blank?
    return type
  end

  def self.set_destination_condition(q, destination, type)
    cond = []
    cond << "marinas.name ILIKE '%#{destination}%'" if !destination.blank? && type[0] == false
    cond << "countries.name ILIKE '%#{destination}%'" if !destination.blank? && type[1] == false
    cond << "regions.name ILIKE  '%#{destination}%'" if !destination.blank? && type[2] == false
    return q.where(cond.join(' OR '))
  end

  private
 
  def validates_format_of_supplier_guid
    return valid_supplier_guid(self.supplier_guid)
  end
  
  def nice_case_names
  	self.name = self.name.titleize
  	self.model_name = self.model_name.titleize
  end
end
