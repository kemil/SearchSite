class Marina < ActiveRecord::Base
  has_many :supplier_marinas
  belongs_to :country
  has_and_belongs_to_many :regions

  ###
  # Find marina names that matches the given term
  #
  # @param [String] term
  ###
  def self.find_names(term, limit=10)
    result = []

    # first try prefix only match
    q = Marina.select('name').where("activated = 1 AND marinas.name ILIKE ? AND activated != ? ", term+'%', 0).group('name').order('name')
    q << Country.select('name').where("countries.name ILIKE ? AND activated != ? ", term+'%', 0).group('name').order('name')
    q << Region.select('name').where("regions.name ILIKE ? AND activated != ? ", term+'%', 0).group('name').order('name')
    
    q.flatten .each do |marina|
      result.push(marina.name)

      break if result.length >= limit
    end

    # if prefix only match does not return result, match anywhere
    if result.length == 0
      q = Marina.select('name').where("activated = 1 AND marinas.name ILIKE ? AND activated != ? ", '%'+term+'%', 0).group('name').order('name')
      q << Country.select('name').where("countries.name ILIKE ? AND activated != ? ", '%'+term+'%', 0).group('name').order('name')
      q << Region.select('name').where("regions.name ILIKE ? AND activated != ? ", '%'+term+'%', 0).group('name').order('name')
      
      q.flatten.each do |marina|
        result.push(marina.name)

        break if result.length >= limit
      end
    end

    return result
  end
end
