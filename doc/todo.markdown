## Things that need to be done

### Minimums
* Make pictures/Paperclip also support boat_models

### Application Layout
* Trim a version for the checkout process
* Filter parameters should not be in url all the time

### Search and booking
* Boat.search_by_destination: dateless part of the code is not safe for avail_periods that require a minimum # number of days for the price to be valid.
* Provide some decent page when there are no results.
* Implement the other views of search results
* Filter "show only cheapest of each yacht model"
* Should use images and texts from BoatModel where appropriate

### Boat info
* When clicking on an image, stop the slider from rotating images.
* Make static version without dates
* Add missing features like calendars, search form etc
* Auto generate description dynamically if none exists

### Homepage
* Make sure form has decent validation.
* Support internationalized dates

### Configuration
* Setup asset hosting to use multiple servers.
* Start using hirefire gem to auto scale workers

### Translations
* All texts on the site should use t().

### Trips
* Show correct status of payments, confirmations etc
* Support multiple invoices, reservations etc
* Some kind of document to print and take with you on the trip

### Booking
* Move sending of email in customers_controller to delayed_job
* Our copy of the email should go to a generic mailbox instead

### Payments
* Also save credit cards number, type, expires etc
* Check that amounts are correct etc before sending to DIBS.
* Should use own amounts instead of dropdown for partial payments
* Design our own payment pages

### Principal extranet
* Write test to verify that login works

### Security
* Start using brakeman to check security
* Go through Rails Guide security for issues

### Users
* Login: send user back to page she came from instead of root
* Javascript signup instead of full page load
* Don't let the user be logged in when signing up.
* Check all the different routes from Devise for AdminUsers. Don't allow signups!

### Performance
* Install MiniProfiler for profiling in browser window easily
* Bullet for warnings of missing eager loading



## Content

### Pages needing content
* /help
* /contactus
* /how-do-i-sail
* /no-sailing-experience-required
* /about
* /terms-and-conditions
* /we-are-more
* /destinations
* /how-it-works

### Inline content needed
* Homepage - three big background pictures
* Homepage - we are more three tag lines
* Homepage - new logo

### Dynamic content
* Boat models
* Boat model pictures
* Boat model texts?
* Attributes
* Regions
* Boats to activate

### External
* Setup Facebook
* Setup Twitter

## Release

### Go-Live
* Replace any Inipix copyright references

### Post Go-Live
* Remove robots.txt from production (not staging)


