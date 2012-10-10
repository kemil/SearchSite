
## Trip
* identifier (the public trip id, won't expose internal id)
* has_one Customer as Reservee
*	has_many BoatReservations
*	has_many Invoices
*	has_many Customers (via BoatReservation > Crews? or virtual)

## Invoice
* identifier (Trip's identifier with added "-n" or as run number/count), currency, date, status (unpaid, partial, paid)
*	has_many InvoiceLines
*	has_many Payments
*	has_one Customer as Buyer
* may_have BoatReservation (needed to connect which boat this is for, eg automation etc?)
	
## InvoiceLines
* belongs_to Invoice
*	belongs_to InvoiceLineTypes
*	description
*	dueamount
*	duevat
*	duetotal
*	costamount
*	costvat
*	costtotal
* costcurrency

## InvoiceLineTypes
*	code (must be unqiue? what's the point vs a free text description?)
* vatgroup (do we need to bother here?)
*	may_have Principal
* has_many InvoiceLines

## Payment
* belongs_to Invoice
*	date, psp, externalref, amount, currency
	
## BoatReservation
* status (new, requested, confirmed, cancelled)
*	has_one Boat
* has_one Principal (via Boat?)
*	rental_start_time
*	rental_end_time
*	has_one SupplierMarina as RentalStart
* has_one SupplierMarina as RentalEnd
* extras (cleaning, fuel etc)
*	has_many Customers as Crew
	
## Customer
*	name, email, address, phone, passport number etc etc


# For Later Implementation

## Tasks
* description, due
* belongs_to Polymorphic BoatReservation, Invoice, Payment

