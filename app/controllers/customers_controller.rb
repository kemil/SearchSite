class CustomersController < ApplicationController

  def index
  end

  def new
    @customer = Customer.new

    # make usa default country
    usa = Country.where(:isocode => 'US').first
    unless usa.blank? then @customer.country_id = usa.id end

    @boat = Boat.find_by_permalink(params[:permalink])
    @avail_price = @boat.boat_avail_prices.find_period(params[:from].to_date, params[:to].to_date).first
    @addons = Addon.where(:activated => 1)
  end
  
  def create
    @customer = Customer.new(params[:customer])
    @boat = Boat.find(params[:boat_id])
    @avail_price = @boat.boat_avail_prices.find_period(params[:from].to_date, params[:to].to_date).first
    @addons = Addon.where(:activated => 1)
    
    
    respond_to do |format|
      if @customer.save
        @trip = Trip.create({:customer_id => @customer.id})
        # initial book reservation will changes later
        @book_reservation = BoatReservation.create(:boat_id => @boat.id, :trip_id => @trip.id,
                                                 :status => BoatReservation::STATUS[:new], :rentaltimestart => params[:from].to_datetime,
                                                 :rentaltimeend => params[:to].to_datetime,
                                                 :rentalmarinastart => @boat.supplier_marina,
                                                 :rentalmarinaend => @boat.supplier_marina)
       
      # initial invoice will changes later
       @invoice = Invoice.new({:trip_id => @trip.id})

       # add the boat's cost
       @invoice.invoice_lines.build(invoice_line_params(@avail_price.total_price, @boat))

       # add addons the user selected
       selected_addons = params[:addon]
       unless selected_addons.blank?
         @addons.each do |addon|
           if !selected_addons["#{addon.id}"].blank? && selected_addons["#{addon.id}"] == "1" # the hash key is a string...
            @invoice.invoice_lines.build(:description => I18n.t(addon.invoice_line_key), :duecount => 1, :dueamount => addon.price(params[:from].to_date, params[:to].to_date), :duevat => 0)
           end
         end
       end

       @invoice.save
       
       flash[:notice] = 'Customer Created'
       format.html { redirect_to trip_path(:identifier => @trip.identifier)}

       begin
         TripMailer.new_trip_email(@trip, @customer.email).deliver
         TripMailer.new_trip_email(@trip, 'erik@inipix.com').deliver
         PrincipalMailer.new_reservation_email(@book_reservation).deliver
       rescue
         logger.warn "Could not send mail to principal!"
       end
     else
       format.html { render :action => "new" }
     end
      
    end
  end
  
  private

  def invoice_line_params(total_price, boat)
   {:description => "#{boat.name} - Ready to sail. #{params[:from]} to #{params[:to]}",
    :duecount => 1,
    :duevat => 0,
    :dueamount => total_price}
  end

end
