class Api::V1::SupplierMarinasController < Api::V1::ApiController
  respond_to :json

  def list
  	@marinas = current_supplier.supplier_marinas
  	respond_with @marinas, Api::V1::ApiCode::SUCCESS
  end
  
  # Create supplier marina also create marina and country if it doesn't exist
  #
  # @param supplier_marina
  #   {
  #     :name => {String},
  #     :country => {String},
  #     :address => {String},
  #     :latitude => {Float},
  #     :longitude => {Float},
  #     :supplier_guid => {String},
  #   }
  def create
    
    begin
      # all or nothing created
      ActiveRecord::Base.transaction do

        # find or create country
        country_name = params[:supplier_marina][:country]
        @country = Country.find_by_name(country_name)
        
        # try with isocode instead
        if @country.blank?
	        @country = Country.find_by_isocode(country_name.upcase)
	      end

        if @country.blank?
          @country = Country.new({:name => country_name})
          @country.save!
        end
        
        # find or create marina
        @marina = Marina.find_by_name(params[:supplier_marina][:name])
        if @marina.blank?
          data = params[:supplier_marina].slice(:name, :address, :latitude, :longitude)
          @marina = @country.marinas.create!(data)
        end

        # create supplier marina
        data = params[:supplier_marina].except(:country)
        data[:country_id] = @country.id
        data[:supplier_id] = current_supplier.id
        @supplier_marina = @marina.supplier_marinas.create!(data)
      end
      
      render :json => Api::V1::ApiCode::SUCCESS
    rescue Exception => e
      response = Api::V1::ApiCode::BAD_REQUEST
      response[:message] = e.message
      render :json => response
    end
  end
  
end
