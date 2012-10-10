class TripMailer < ActionMailer::Base
  default from: "ynf.notifications@gmail.com"
  layout "email"

  def new_trip_email(trip, email)
  	@trip = trip

  	begin
	  	@subject = "Your reservation to #{trip.boat_reservations.first.rentalmarinastart.marina.name} #{trip.identifier}"
	  rescue
	  	@subject = "Your reservation #{trip.identifier}"
	  end

		mail(:to => email, :subject => @subject)
  end

end
