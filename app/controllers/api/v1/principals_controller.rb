class Api::V1::PrincipalsController < Api::V1::ApiController
  def list
    @principals = current_supplier.principals
    respond_with @principals
  end
  
  def create
    name = params[:name]
    supplier_guid = params[:supplier_guid]
    
    p = current_supplier.principals.new(:name => name, :supplier_guid => supplier_guid)
    if p.save
      render :json => Api::V1::ApiCode::SUCCESS
    else
      response = Api::V1::ApiCode::BAD_REQUEST
      if p.errors and p.errors.full_messages.length > 0
        response[:message] = p.errors.full_messages[0]
      end
      render :json => response
    end
  end
end
