class Api::V1::BoatPicturesController < Api::V1::ApiController
  before_filter :require_boat
  
  def list
    @pictures = @boat.pictures
    respond_with @pictures
  end

  def create
    picture = @boat.pictures.new(params[:picture])
    if picture.save
      render :json => Api::V1::ApiCode::SUCCESS
    else
      response = Api::V1::ApiCode::BAD_REQUEST
      if picture.errors and picture.errors.full_messages.length > 0
        response[:message] = picture.errors.full_messages[0]
      end
      render :json => response
    end
  end
  
  private

  def require_boat
    if params[:boat_id].nil? and params[:boat_guid].nil?
      response = Api::V1::ApiCode::BAD_REQUEST
      response[:message] = 'Parameter `boat_id` or `boat_guid` is required'
      render :json => response
      return false
    end
    
    if !params[:boat_id].nil?
      @boat = Boat.find_by_id(params[:boat_id])
      if @boat.nil?
        response = Api::V1::ApiCode::BAD_REQUEST
        response[:message] = 'Boat with id = `' + params[:boat_id] + '` is not found'
        render :json => response
        return false
      end
    else
      @boat = Boat.find_by_supplier_guid(params[:boat_guid])
      if @boat.nil?
        response = Api::V1::ApiCode::BAD_REQUEST
        response[:message] = 'Boat with supplier_guid = `' + params[:boat_guid] + '` is not found'
        render :json => response
        return false
      end
    end
    
    return true
  end
end
