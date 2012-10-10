class Reservations < ActionMailer::Base
  
  def send_renter_boat_notification(renter, reservation, amount)
    @from            = "admin@tlsite.com"
    @sent_on         = Time.now
    @content_type    = "text/html;"
    @recipients      = renter.email
    @renter          = renter
    @reservation     = reservation
    @boat            = reservation.boat
    @amount          = amount
    @subject         = "Your #{@boat.name} in #{@boat.supplier_marina.country.name} is reserved"
  end
  
  def send_owner_boat_notification(owner)
  end
  
end
