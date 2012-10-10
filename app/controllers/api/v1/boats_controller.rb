class Api::V1::BoatsController < Api::V1::ApiController
  def list
    # boat supplier_guid is specified, get that specific boat
    boat_supplier_guid = params[:boat_guid]
    if not boat_supplier_guid.blank?
      @boats = Boat.where(:supplier_guid => boat_supplier_guid)
      respond_with @boats
      return
    end
    
    # principal supplier_guid is specified, get boat from current_supplier and 
    # that principal
    principal_supplier_guid = params[:principal_guid]
    if not principal_supplier_guid.blank?
      principal = Principal.where(:supplier_guid => principal_supplier_guid).first
      @boats = Boat.where("principal_id = ? AND supplier_id = ?", 
                          principal.id, current_supplier.id)
      respond_with @boats
      return
    end
    
    # no parameter specified, return boats for current_supplier
    @boats = Boat.where(:supplier_id => current_supplier.id)
    respond_with @boats
  end

  def create
    @boat = Boat.new(params[:boat])
    @boat.supplier = current_supplier
    
    # set principal id
    if params[:boat][:principal_id].blank? 
      if !params[:principal_guid].blank?
        principal = Principal.find_by_supplier_guid( params[:principal_guid] )
        @boat.principal = principal
      else
        response = Api::V1::ApiCode::BAD_REQUEST
        response[:message] = '`principal_guid` not specified'
        render :json => response
        return
      end
    end
    
    logger.info 'principal was set'
    
    # set supplier marina id
    if params[:boat][:supplier_marina_id].blank? 
      if !params[:supplier_marina_guid].blank?
        guid = params[:supplier_marina_guid]
        supplier_marina = SupplierMarina.find_by_supplier_guid( guid )
        @boat.supplier_marina = supplier_marina
      else
        response = Api::V1::ApiCode::BAD_REQUEST
        response[:message] = '`supplier_marina_guid` not specified'
        render :json => response
        return
      end
    end
    
    logger.info 'supplier marina set'
    
    if @boat.save
      render :json => Api::V1::ApiCode::SUCCESS
    else
      response = Api::V1::ApiCode::BAD_REQUEST
      if @boat.errors and @boat.errors.full_messages.length > 0
        response[:message] = @boat.errors.full_messages[0]
        logger.info 'errors saving boat: ' +  @boat.errors.full_messages[0]
      end
      render :json => response
    end
  end
end
