class ReservationsController < ApplicationController
  def index
  	if params.has_key?(:identifier)
	  	redirect_to :action => "show", :identifier => params[:identifier].upcase
	  else
	  	render 'index'
	  end
  end
  
  def show
    @trip = Trip.find_by_identifier(params[:identifier].upcase)

   	redirect_to :action => 'index' if @trip.nil?
  end

end
