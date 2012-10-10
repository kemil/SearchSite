class Api::V1::BoatAvailPricesController < Api::V1::ApiController
	respond_to :json
	
	def list
		unless params[:boat_id] || params[:boat_guid]
			@boats = Boat.all
			respond_with @boats
		else
			@boat = Boat.find_by_id params[:boat_id] if params[:boat_id]
			@boat = Boat.find_by_supplier_guid params[:boat_guid] if params[:boat_guid]
			if @boat
				respond_with @boat
      else
        response = Api::V1::ApiCode::BAD_REQUEST
        response[:message] = 'No boat found for the given `boat_id` or `boat_guid`'
				render :json => response
			end
		end
	end
	
	def create
    @boat = find_boat_by_id_or_guid(params)

    if @boat.nil?
      response = Api::V1::ApiCode::BAD_REQUEST
      response[:message] = 'No boat found for the given `boat_id` or `boat_guid`'
      render :json => response
      return
    end

    begin
      @boat_avail = @boat.boat_avail_prices.new(params[:avail_boat])
      @boat_avail.save!
      response = Api::V1::ApiCode::SUCCESS
    rescue
      response = Api::V1::ApiCode::BAD_REQUEST
      if @boat_avail.errors and @boat_avail.errors.full_messages.length > 0
        response[:message] = @boat_avail.errors.full_messages[0]
      end
    end
    render :json => response
	end
	
	def update
    @boat_avail = BoatAvailPrice.find_by_id(params[:id])

    if @boat_avail.nil?
      response = Api::V1::ApiCode::BAD_REQUEST
      response[:message] = 'Boat available price not found for the given `id`'
      render :json => response
      return
    end

		begin
			@boat_avail.update_attributes!(params[:avail_boat])
      response = Api::V1::ApiCode::SUCCESS
    rescue
			response = Api::V1::ApiCode::BAD_REQUEST
      if @boat_avail.errors and @boat_avail.errors.full_messages.length > 0
        response[:message] = @boat_avail.errors.full_messages[0]
      end
    end

		render :json => response
	end
	
	def destroy
		if request.delete?
			begin
				boat_avail = BoatAvailPrice.find_by_id params[:id]
				boat_avail.destroy
				response = Api::V1::ApiCode::SUCCESS
			rescue
				response = Api::V1::ApiCode::BAD_REQUEST
			end
			render :json => response
		end
	end
	
	private
      
  def find_boat_by_id_or_guid(params)
    if params[:boat_guid] != nil
      Boat.find_by_supplier_guid(params[:boat_guid])
    else
      Boat.find_by_id(params[:boat_id])
    end
  end
end
