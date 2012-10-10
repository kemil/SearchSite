class PrincipalMailer < ActionMailer::Base
  default from: "ynf.notifications"
  layout "email"

  def new_reservation_email(boat_reservation)
  	@boat_reservation = boat_reservation
  	@principal = boat_reservation.boat.principal
  	@subject = "#{@principal.name} needs to approve/deny new reservation - Action required"

  	if @principal.try(:notificationemail)
		  mail(:to => @principal.notificationemail, :subject => @subject)
  	end
  end

end
