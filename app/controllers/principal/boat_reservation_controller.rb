class Principal::BoatReservationController < Principal::PrincipalController
  load_and_authorize_resource :boat_reservation

  def index
  end

  def show
  end

  def update

  	if not @boat_reservation.nil?

	  	if @boat_reservation.status == BoatReservation::STATUS[:new] && @boat_reservation.rentaltimestart > Time.now
	  		@boat_reservation.status = params[:boat_reservation][:status]

	  		if @boat_reservation.status == BoatReservation::STATUS[:confirmed]
		  		@boat_reservation.externalref = params[:boat_reservation][:externalref] 
		  	end

	  		@boat_reservation.save
	  	end

	  	redirect_to principal_boat_reservation_path(@boat_reservation)
	end
  end

end
