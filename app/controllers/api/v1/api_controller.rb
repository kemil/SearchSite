class Api::V1::ApiController < ActionController::Base
  protect_from_forgery
  
  respond_to :json
  before_filter :require_supplier, :set_default_response_format
  helper_method :current_supplier
  
  VERSION = {:version => "1.0"}
  ENVIRONMENT = {:environment => Rails.env}
  
  def version
    render :json => VERSION
  end

  def environment
    render :json => ENVIRONMENT
  end
  
  private
  
  def set_default_response_format
    request.format = 'json'.to_sym if params[:format].nil?
  end
  
  def current_supplier
    return @current_supplier if defined?(@current_supplier)
  end

  def require_supplier
    if defined?(@current_supplier)
      return true
    else
      if request.headers['API-Key'].blank?
        render :json => Api::V1::ApiCode::INVALID_API_KEY, :status => 401
        return false
      end
      
      # get current supplier from access token
      access_token = request.headers['API-Key']
      @current_supplier = Supplier.find_by_access_token(access_token)
      
      if not @current_supplier
        render :json => Api::V1::ApiCode::INVALID_API_KEY, :status => 401
        return false
      end
      
      return true
    end
  end
end

class Api::V1::ApiCode
  SUCCESS = {:code => 200, :message => 'Success'}
  INTERNAL_ERROR = {:code => 500, :message => 'Internal Server Error'}
  BAD_REQUEST = {:code => 400, :message => 'Bad request'}
  INVALID_API_KEY = {:code => 401, :message => 'Invalid access token'}
end
