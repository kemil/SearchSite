class BoatsController < ApplicationController
  
  def show
    @boat = Boat.find_by_permalink(params[:permalink])
    if !@boat.nil?
      @avail_price = @boat.boat_avail_prices.find_period(params[:from].to_date, params[:to].to_date).first if !params[:from].nil? && !params[:to].nil?
    end
  end

end
