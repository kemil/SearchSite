Example API Usage
=================

Basic Authentication
--------------------

### Version

	curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	http://127.0.0.1:3000/api/v1/version


Principals
----------

### List

	curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	http://127.0.0.1:3000/api/v1/principals/list

### Create

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "name=New&supplier_guid=newp" \
	http://127.0.0.1:3000/api/v1/principals


Supplier Marinas
-----------------

### List

	curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	http://127.0.0.1:3000/api/v1/supplier_marinas/list

### Create

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "supplier_marina[name]=New+Marina2&supplier_marina[supplier_guid]=newmarina2&supplier_marina[address]=Main+Street+1,Croatia&supplier_marina[longitude]=16.92828&supplier_marina[latitude]=43.545655&&supplier_marina[supplier_guid]=Testing+Supplier+Guid&supplier_marina[country_id]=1" \
	http://127.0.0.1:3000/api/v1/supplier_marinas


Boats
-----

### List

    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boats/list
    
    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boats/list?principal_guid=navigare

    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boats/list?boat_guid=navigare_ingrid

### Create

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "supplier_marina_guid=navigare_kastela&principal_guid=navigare&boat[name]=Johanna&boat[supplier_guid]=navigare_johanna&boat[model_name]=Bavaria+42&boat[model_year]=2011&boat[description]=You+will+love+this+boat&boat[hull]=mono&boat[length_ft]=42&boat[cabins]=4&boat[berths]=8&boat[heads]=2&boat[max_persons]=8&boat[fuel_capacity]=300&boat[water_capacity]=420" \
	http://127.0.0.1:3000/api/v1/boats

Also works with internal id's on boat level:

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "boat[name]=Johanna&boat[supplier_guid]=navigare_johanna&boat[model_name]=Bavaria+42&boat[model_year]=2011&boat[description]=You+will+love+this+boat&boat[supplier_marina_id]=1&boat[principal_id]=1&boat[hull]=mono&boat[length_ft]=42&boat[cabins]=4&boat[berths]=8&boat[heads]=2&boat[max_persons]=8&boat[fuel_capacity]=300&boat[water_capacity]=420" \
	http://127.0.0.1:3000/api/v1/boats


Boat Pictures
-------------

### List

    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boat_pictures/list?boat_id=1

    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boat_pictures/list?boat_guid=navigare_ingrid

### Create

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "boat_id=1&picture[url]=http://www.dn.se/Images/2011/10/12/dnse-logo.png&picture[width]=208&picture[height]=68&picture[description]=This+is+a+logo" \
	http://127.0.0.1:3000/api/v1/boat_pictures


Boat Avail Prices
-----------------

### General List

    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boat_avail_prices/list

### List a specific boat

    curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
    http://127.0.0.1:3000/api/v1/boat_avail_prices/list?boat_id=1

### Create by boat_id

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "boat_id=1&avail_boat[period_start]=2012-12-01&avail_boat[period_end]=2012-12-08&avail_boat[period_price]=500&avail_boat[period_nights]=7" \
	http://127.0.0.1:3000/api/v1/boat_avail_prices
	
### Create by boat.supplier_guid

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "boat_guid=navigare_ingrid&avail_boat[period_start]=2012-12-01&avail_boat[period_end]=2012-12-08&avail_boat[period_price]=500&avail_boat[period_nights]=7" \
	http://127.0.0.1:3000/api/v1/boat_avail_prices
	
### Update

	curl -X PUT \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "avail_boat[boat_id]=1&avail_boat[period_start]=2012-12-01&avail_boat[period_end]=2012-12-08&avail_boat[period_price]=500&avail_boat[period_nights]=7" \
	http://127.0.0.1:3000/api/v1/boat_avail_prices/1

### Delete

	curl -X DELETE \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	http://127.0.0.1:3000/api/v1/boat_avail_prices/5

Boat Attributes
---------------

### List

  curl -X GET \
  -H "API-Key: 003e43a433f27d2597627edda018c98e" \
  http://127.0.0.1:3000/api/v1/boat_attributes/list?boat_id=1

  curl -X GET \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
  http://127.0.0.1:3000/api/v1/boat_attributes/list?boat_guid=navigare_ingrid

### Create

	curl -X POST \
	-H "API-Key: 003e43a433f27d2597627edda018c98e" \
	-d "boat_id=1&attribute[key]=GPS+Navigation&attribute[value]=true" \
	http://127.0.0.1:3000/api/v1/boat_attributes

