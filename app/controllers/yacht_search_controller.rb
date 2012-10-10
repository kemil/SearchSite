class YachtSearchController < ApplicationController

  respond_to :html, :json

  def search
    @destination = params[:destination]
    @destination = CGI::unescape(@destination) if !@destination.nil?
    @destination.strip!
    # found nice case name in marina table
    marina = Marina.find_by_name(@destination)
    @destination = marina.name if !marina.nil?

    @people = params[:people]
    @people = CGI::unescape(@people) if !@people.nil?
    @people = @people.to_i
    if @people == 0
      @people = 1
    end

    @pickup_date = params[:pickup]
    @pickup_date = CGI::unescape(@pickup_date) if !@pickup_date.nil?
    begin
      @pickup_date = Date.parse( @pickup_date )
    rescue
      @pickup_date = nil
    end

    @return_date = params[:return]
    @return_date = CGI::unescape(@return_date) if !@return_date.nil?
    begin
      @return_date = Date.parse( @return_date )
    rescue
      @return_date = nil
    end

  	@available = Boat.search(@destination, @people, @pickup_date, @return_date)
    @filters = generate_filter(@available)
    puts @filters

    respond_with(@available)
  end

  def search_proxy
    destination = params[:destination]
    people = params[:people]
    pickup_date = params[:pickup]
    return_date = params[:return]

    url_params = {
      :controller => 'yacht_search',
      :action => 'search'
    }

    if destination.blank?
      destination = ' ' # avoid empty destination for the routing to work
    end

    url_params[:destination] = CGI::escape(destination.downcase)
    url_params[:people] = CGI::escape(people) if !people.blank?
    url_params[:pickup] = CGI::escape(pickup_date) if !pickup_date.blank?
    url_params[:return] = CGI::escape(return_date) if !return_date.blank?

    url = url_for(url_params)
    redirect_to url
  end

  private

  def generate_filter(boats)
    # construct filters
    @filters = [
        {
            :name => 'hull',
            :values => [],
            :type => 'checkbox'
        },
        {
            :name => 'cabins',
            :values => [],
            :type => 'slider'
        },
        {
            :name => 'age',
            :values => [],
            :type => 'slider'
        },
        {
            :name => 'marina',
            :values => [],
            :type => 'checkbox'
        },
        {
            :name => 'model',
            :values => [],
            :type => 'checkbox'
        },
        {
            :name => 'length',
            :values => [],
            :type => 'slider'
        },
        {
          
          :name => 'boat_attributes',
          :values => [],
          :type => 'checkbox'
        }
    ]

    for boat in @available do
      hull = boat[:hull]
      unless @filters[0][:values].include?(hull)
        @filters[0][:values].push(hull)
      end

      cabins = boat[:cabins]
      unless @filters[1][:values].include?(cabins)
        @filters[1][:values].push(cabins)
      end

      age = Time.now.year - boat.model_year
      unless @filters[2][:values].include?(age)
        @filters[2][:values].push(age)
      end

      marina = boat.supplier_marina.marina.name
      unless @filters[3][:values].include?(marina)
        @filters[3][:values].push(marina)
      end

      model = boat[:model_name]
      unless @filters[4][:values].include?(model)
        @filters[4][:values].push(model)
      end

      length = boat[:length_ft]
      unless @filters[5][:values].include?(length)
        @filters[5][:values].push(length)
      end
      
      boat.boat_attribute_standard_values.each do |ba|
        unless @filters[6][:values].include?([ba.standard_attribute.description, ba.value].join(','))
          @filters[6][:values].push([ba.standard_attribute.description, ba.value].join(','))
        end
      end
      
    end

    # sort values
    @filters.each do |filter|
      filter[:values].sort!
    end

    # set min and max
    @filters.each do |filter|
      if filter[:type] == 'slider'
        values = filter[:values]
        if values.length > 0
          filter[:min] = values[0]
          filter[:max] = values[ values.length-1 ]
        else
          filter[:min] = 0
          filter[:max] = 0
        end
      end
    end
  end

end
