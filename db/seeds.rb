# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)
countries = Country.create([
{:name => 'Åland Islands', :isocode => 'AX'},
{:name => 'Albania', :isocode => 'AL'},
{:name => 'Algeria', :isocode => 'DZ'},
{:name => 'American Samoa', :isocode => 'AS'},
{:name => 'Andorra', :isocode => 'AD'},
{:name => 'Angola', :isocode => 'AO'},
{:name => 'Anguilla', :isocode => 'AI'},
{:name => 'Antarctica', :isocode => 'AQ'},
{:name => 'Antigua and Barbuda', :isocode => 'AG'},
{:name => 'Argentina', :isocode => 'AR'},
{:name => 'Armenia', :isocode => 'AM'},
{:name => 'Aruba', :isocode => 'AW'},
{:name => 'Australia', :isocode => 'AU'},
{:name => 'Austria', :isocode => 'AT'},
{:name => 'Azerbaijan', :isocode => 'AZ'},
{:name => 'Bahamas', :isocode => 'BS'},
{:name => 'Bahrain', :isocode => 'BH'},
{:name => 'Bangladesh', :isocode => 'BD'},
{:name => 'Barbados', :isocode => 'BB'},
{:name => 'Belarus', :isocode => 'BY'},
{:name => 'Belgium', :isocode => 'BE'},
{:name => 'Belize', :isocode => 'BZ'},
{:name => 'Benin', :isocode => 'BJ'},
{:name => 'Bermuda', :isocode => 'BM'},
{:name => 'Bhutan', :isocode => 'BT'},
{:name => 'Bolivia', :isocode => 'BO'},
{:name => 'Bosnia and Herzegovina', :isocode => 'BA'},
{:name => 'Botswana', :isocode => 'BW'},
{:name => 'Bouvet Island', :isocode => 'BV'},
{:name => 'Brazil', :isocode => 'BR'},
{:name => 'British Indian Ocean Territory', :isocode => 'IO'},
{:name => 'Brunei Darussalam', :isocode => 'BN'},
{:name => 'Bulgaria', :isocode => 'BG'},
{:name => 'Burkina Faso', :isocode => 'BF'},
{:name => 'Burundi', :isocode => 'BI'},
{:name => 'Cambodia', :isocode => 'KH'},
{:name => 'Cameroon', :isocode => 'CM'},
{:name => 'Canada', :isocode => 'CA'},
{:name => 'Cape Verde', :isocode => 'CV'},
{:name => 'Cayman Islands', :isocode => 'KY'},
{:name => 'Central African Republic', :isocode => 'CF'},
{:name => 'Chad', :isocode => 'TD'},
{:name => 'Chile', :isocode => 'CL'},
{:name => 'China', :isocode => 'CN'},
{:name => 'Christmas Island', :isocode => 'CX'},
{:name => 'Cocos (Keeling) Islands', :isocode => 'CC'},
{:name => 'Colombia', :isocode => 'CO'},
{:name => 'Comoros', :isocode => 'KM'},
{:name => 'Congo', :isocode => 'CG'},
{:name => 'Congo, The Democratic Republic of The', :isocode => 'CD'},
{:name => 'Cook Islands', :isocode => 'CK'},
{:name => 'Costa Rica', :isocode => 'CR'},
{:name => 'Côte D\'Ivoire', :isocode => 'CI'},
{:name => 'Croatia', :isocode => 'HR'},
{:name => 'Cuba', :isocode => 'CU'},
{:name => 'Cyprus', :isocode => 'CY'},
{:name => 'Czech Republic', :isocode => 'CZ'},
{:name => 'Denmark', :isocode => 'DK'},
{:name => 'Djibouti', :isocode => 'DJ'},
{:name => 'Dominica', :isocode => 'DM'},
{:name => 'Dominican Republic', :isocode => 'DO'},
{:name => 'Ecuador', :isocode => 'EC'},
{:name => 'Egypt', :isocode => 'EG'},
{:name => 'El Salvador', :isocode => 'SV'},
{:name => 'Equatorial Guinea', :isocode => 'GQ'},
{:name => 'Eritrea', :isocode => 'ER'},
{:name => 'Estonia', :isocode => 'EE'},
{:name => 'Ethiopia', :isocode => 'ET'},
{:name => 'Falkland Islands (Malvinas)', :isocode => 'FK'},
{:name => 'Faroe Islands', :isocode => 'FO'},
{:name => 'Fiji', :isocode => 'FJ'},
{:name => 'Finland', :isocode => 'FI'},
{:name => 'France', :isocode => 'FR'},
{:name => 'French Guiana', :isocode => 'GF'},
{:name => 'French Polynesia', :isocode => 'PF'},
{:name => 'French Southern Territories', :isocode => 'TF'},
{:name => 'Gabon', :isocode => 'GA'},
{:name => 'Gambia', :isocode => 'GM'},
{:name => 'Georgia', :isocode => 'GE'},
{:name => 'Germany', :isocode => 'DE'},
{:name => 'Ghana', :isocode => 'GH'},
{:name => 'Gibraltar', :isocode => 'GI'},
{:name => 'Greece', :isocode => 'GR'},
{:name => 'Greenland', :isocode => 'GL'},
{:name => 'Grenada', :isocode => 'GD'},
{:name => 'Guadeloupe', :isocode => 'GP'},
{:name => 'Guam', :isocode => 'GU'},
{:name => 'Guatemala', :isocode => 'GT'},
{:name => 'Guernsey', :isocode => 'GG'},
{:name => 'Guinea', :isocode => 'GN'},
{:name => 'Guinea-Bissau', :isocode => 'GW'},
{:name => 'Guyana', :isocode => 'GY'},
{:name => 'Haiti', :isocode => 'HT'},
{:name => 'Heard Island and Mcdonald Islands', :isocode => 'HM'},
{:name => 'Holy See (Vatican City State)', :isocode => 'VA'},
{:name => 'Honduras', :isocode => 'HN'},
{:name => 'Hong Kong', :isocode => 'HK'},
{:name => 'Hungary', :isocode => 'HU'},
{:name => 'Iceland', :isocode => 'IS'},
{:name => 'India', :isocode => 'IN'},
{:name => 'Indonesia', :isocode => 'ID'},
{:name => 'Iran, Islamic Republic of', :isocode => 'IR'},
{:name => 'Iraq', :isocode => 'IQ'},
{:name => 'Ireland', :isocode => 'IE'},
{:name => 'Isle of Man', :isocode => 'IM'},
{:name => 'Israel', :isocode => 'IL'},
{:name => 'Italy', :isocode => 'IT'},
{:name => 'Jamaica', :isocode => 'JM'},
{:name => 'Japan', :isocode => 'JP'},
{:name => 'Jersey', :isocode => 'JE'},
{:name => 'Jordan', :isocode => 'JO'},
{:name => 'Kazakhstan', :isocode => 'KZ'},
{:name => 'Kenya', :isocode => 'KE'},
{:name => 'Kiribati', :isocode => 'KI'},
{:name => 'Korea, Democratic People\'s Republic of', :isocode => 'KP'},
{:name => 'Korea, Republic of', :isocode => 'KR'},
{:name => 'Kuwait', :isocode => 'KW'},
{:name => 'Kyrgyzstan', :isocode => 'KG'},
{:name => 'Lao People\'s Democratic Republic', :isocode => 'LA'},
{:name => 'Latvia', :isocode => 'LV'},
{:name => 'Lebanon', :isocode => 'LB'},
{:name => 'Lesotho', :isocode => 'LS'},
{:name => 'Liberia', :isocode => 'LR'},
{:name => 'Libyan Arab Jamahiriya', :isocode => 'LY'},
{:name => 'Liechtenstein', :isocode => 'LI'},
{:name => 'Lithuania', :isocode => 'LT'},
{:name => 'Luxembourg', :isocode => 'LU'},
{:name => 'Macao', :isocode => 'MO'},
{:name => 'Macedonia, The Former Yugoslav Republic of', :isocode => 'MK'},
{:name => 'Madagascar', :isocode => 'MG'},
{:name => 'Malawi', :isocode => 'MW'},
{:name => 'Malaysia', :isocode => 'MY'},
{:name => 'Maldives', :isocode => 'MV'},
{:name => 'Mali', :isocode => 'ML'},
{:name => 'Malta', :isocode => 'MT'},
{:name => 'Marshall Islands', :isocode => 'MH'},
{:name => 'Martinique', :isocode => 'MQ'},
{:name => 'Mauritania', :isocode => 'MR'},
{:name => 'Mauritius', :isocode => 'MU'},
{:name => 'Mayotte', :isocode => 'YT'},
{:name => 'Mexico', :isocode => 'MX'},
{:name => 'Micronesia, Federated States of', :isocode => 'FM'},
{:name => 'Moldova, Republic of', :isocode => 'MD'},
{:name => 'Monaco', :isocode => 'MC'},
{:name => 'Mongolia', :isocode => 'MN'},
{:name => 'Montenegro', :isocode => 'ME'},
{:name => 'Montserrat', :isocode => 'MS'},
{:name => 'Morocco', :isocode => 'MA'},
{:name => 'Mozambique', :isocode => 'MZ'},
{:name => 'Myanmar', :isocode => 'MM'},
{:name => 'Namibia', :isocode => 'NA'},
{:name => 'Nauru', :isocode => 'NR'},
{:name => 'Nepal', :isocode => 'NP'},
{:name => 'Netherlands', :isocode => 'NL'},
{:name => 'Netherlands Antilles', :isocode => 'AN'},
{:name => 'New Caledonia', :isocode => 'NC'},
{:name => 'New Zealand', :isocode => 'NZ'},
{:name => 'Nicaragua', :isocode => 'NI'},
{:name => 'Niger', :isocode => 'NE'},
{:name => 'Nigeria', :isocode => 'NG'},
{:name => 'Niue', :isocode => 'NU'},
{:name => 'Norfolk Island', :isocode => 'NF'},
{:name => 'Northern Mariana Islands', :isocode => 'MP'},
{:name => 'Norway', :isocode => 'NO'},
{:name => 'Oman', :isocode => 'OM'},
{:name => 'Pakistan', :isocode => 'PK'},
{:name => 'Palau', :isocode => 'PW'},
{:name => 'Palestinian Territory, Occupied', :isocode => 'PS'},
{:name => 'Panama', :isocode => 'PA'},
{:name => 'Papua New Guinea', :isocode => 'PG'},
{:name => 'Paraguay', :isocode => 'PY'},
{:name => 'Peru', :isocode => 'PE'},
{:name => 'Philippines', :isocode => 'PH'},
{:name => 'Pitcairn', :isocode => 'PN'},
{:name => 'Poland', :isocode => 'PL'},
{:name => 'Portugal', :isocode => 'PT'},
{:name => 'Puerto Rico', :isocode => 'PR'},
{:name => 'Qatar', :isocode => 'QA'},
{:name => 'Réunion', :isocode => 'RE'},
{:name => 'Romania', :isocode => 'RO'},
{:name => 'Russian Federation', :isocode => 'RU'},
{:name => 'Rwanda', :isocode => 'RW'},
{:name => 'Saint Barthélemy', :isocode => 'BL'},
{:name => 'Saint Helena, Ascension and Tristan Da Cunha', :isocode => 'SH'},
{:name => 'Saint Kitts and Nevis', :isocode => 'KN'},
{:name => 'Saint Lucia', :isocode => 'LC'},
{:name => 'Saint Martin', :isocode => 'MF'},
{:name => 'Saint Pierre and Miquelon', :isocode => 'PM'},
{:name => 'Saint Vincent and The Grenadines', :isocode => 'VC'},
{:name => 'Samoa', :isocode => 'WS'},
{:name => 'San Marino', :isocode => 'SM'},
{:name => 'Sao Tome and Principe', :isocode => 'ST'},
{:name => 'Saudi Arabia', :isocode => 'SA'},
{:name => 'Senegal', :isocode => 'SN'},
{:name => 'Serbia', :isocode => 'RS'},
{:name => 'Seychelles', :isocode => 'SC'},
{:name => 'Sierra Leone', :isocode => 'SL'},
{:name => 'Singapore', :isocode => 'SG'},
{:name => 'Slovakia', :isocode => 'SK'},
{:name => 'Slovenia', :isocode => 'SI'},
{:name => 'Solomon Islands', :isocode => 'SB'},
{:name => 'Somalia', :isocode => 'SO'},
{:name => 'South Africa', :isocode => 'ZA'},
{:name => 'South Georgia and The South Sandwich Islands', :isocode => 'GS'},
{:name => 'Spain', :isocode => 'ES'},
{:name => 'Sri Lanka', :isocode => 'LK'},
{:name => 'Sudan', :isocode => 'SD'},
{:name => 'Suriname', :isocode => 'SR'},
{:name => 'Svalbard and Jan Mayen', :isocode => 'SJ'},
{:name => 'Swaziland', :isocode => 'SZ'},
{:name => 'Sweden', :isocode => 'SE'},
{:name => 'Switzerland', :isocode => 'CH'},
{:name => 'Syrian Arab Republic', :isocode => 'SY'},
{:name => 'Taiwan, Province of China', :isocode => 'TW'},
{:name => 'Tajikistan', :isocode => 'TJ'},
{:name => 'Tanzania, United Republic of', :isocode => 'TZ'},
{:name => 'Thailand', :isocode => 'TH'},
{:name => 'Timor-Leste', :isocode => 'TL'},
{:name => 'Togo', :isocode => 'TG'},
{:name => 'Tokelau', :isocode => 'TK'},
{:name => 'Tonga', :isocode => 'TO'},
{:name => 'Trinidad and Tobago', :isocode => 'TT'},
{:name => 'Tunisia', :isocode => 'TN'},
{:name => 'Turkey', :isocode => 'TR'},
{:name => 'Turkmenistan', :isocode => 'TM'},
{:name => 'Turks and Caicos Islands', :isocode => 'TC'},
{:name => 'Tuvalu', :isocode => 'TV'},
{:name => 'Uganda', :isocode => 'UG'},
{:name => 'Ukraine', :isocode => 'UA'},
{:name => 'United Arab Emirates', :isocode => 'AE'},
{:name => 'United Kingdom', :isocode => 'GB'},
{:name => 'United States', :isocode => 'US'},
{:name => 'United States Minor Outlying Islands', :isocode => 'UM'},
{:name => 'Uruguay', :isocode => 'UY'},
{:name => 'Uzbekistan', :isocode => 'UZ'},
{:name => 'Vanuatu', :isocode => 'VU'},
{:name => 'Venezuela, Bolivarian Republic of', :isocode => 'VE'},
{:name => 'Viet Nam', :isocode => 'VN'},
{:name => 'Virgin Islands, British', :isocode => 'VG'},
{:name => 'Virgin Islands, U.S.', :isocode => 'VI'},
{:name => 'Wallis and Futuna', :isocode => 'WF'},
{:name => 'Western Sahara', :isocode => 'EH'},
{:name => 'Yemen', :isocode => 'YE'},
{:name => 'Zambia', :isocode => 'ZM'},
{:name => 'Zimbabwe', :isocode => 'ZW'}
])

hr = Country.find_by_isocode('HR')
bm = Supplier.create(name: 'Booking Manager', access_token: '003e43a433f27d2597627edda018c98e')
supplier_navy = Supplier.create(name: 'Navy')
navigare = Principal.create(name: 'Navigare', supplier: bm, supplier_guid: 'navigare')
naviblue = Principal.create(name: 'Naviblue', supplier: supplier_navy, supplier_guid: 'naviblue')

kastela = Marina.create(name: 'Kastela', country: hr, address: "Šetalište kralja Tomislava bb, 21 213 Kaštel Gomilica, Croatia", latitude: 43.545655, longitude: 16.404927, activated: 1)
sup_kastela = SupplierMarina.create(name: 'Kastela', supplier: bm, supplier_guid: 'navigare_kastela', country: hr, address: 'Šetalište kralja Tomislava bb, 21 213 Kaštel Gomilica, Croatia', latitude: 43.545655, longitude: 16.404927, marina: kastela)

porec = Marina.create(name: 'Porec', country: hr, address: "52 440 Poreč Turističko šetalište 9, Hrvatska, Croatia", activated: 1)
sup_porec = SupplierMarina.create(name: 'Porec', supplier: bm, supplier_guid: 'navigare_porec', country: hr, address: '52 440 Poreč Turističko šetalište 9, Hrvatska, Croatia', marina: porec)

bavaria38cruiser = BoatModel.create(name: 'Bavaria 38 Cruiser')
bav38cruisermatch = BoatModelMatch.create(matcher: 'bavaria 38 cruiser', boat_model: bavaria38cruiser)

ingrid = Boat.create(supplier_guid: 'navigare_ingrid', supplier: bm, name: 'Ingrid', model_name: 'Bavaria 38 Cruiser', model_year: '2011', supplier_marina: sup_kastela, principal: navigare, activated: 1, description: 'An amazing family boat the takes the waves with awe!', hull: 'mono', length_ft: '48', cabins: 5, berths: 6, heads: 1, max_persons: 6, fuel_capacity: 200, water_capacity: 150)
miranda = Boat.create(supplier_guid: 'navigare_miranda', supplier: bm, name: 'Miranda', model_name: 'Bavaria 38 Cruiser', model_year: '2009', supplier_marina: sup_kastela, principal: navigare, activated: 1, description: 'An amazing family boat the takes the waves with awe!', hull: 'mono', length_ft: '38', cabins: 3, berths: 6, heads: 1, max_persons: 6, fuel_capacity: 200, water_capacity: 150)
lisa = Boat.create(supplier_guid: 'naviblue_lisa', supplier: bm, name: 'Lisa', model_name: 'Bavaria 38 Cruiser', model_year: '2007', supplier_marina: sup_porec, principal: naviblue, activated: 1, description: 'An amazing family boat the takes the waves with awe!', hull: 'mono', length_ft: '55', cabins: 7, berths: 6, heads: 1, max_persons: 6, fuel_capacity: 200, water_capacity: 150)

ingridpic1 = Picture.find_or_create_by_url(url: 'http://www.navigare-yachting.com/$-1/thumb/640x420/38cr-bb-hinten-04.jpg', width: 600, height: 400, description: 'Sailing', imageable: ingrid)
ingridpic2 = Picture.find_or_create_by_url(url: 'http://www.navigare-yachting.com/$-1/thumb/640x420/capture-32179.jpg', width: 583, height: 420, description: 'Dining area', imageable: lisa)
ingridpic3 = Picture.find_or_create_by_url(url: 'http://www.navigare-yachting.com/$-1/thumb/640x420/capture-3-7.jpg', width: 553, height: 420, description: 'Main cabin', imageable: miranda)

ingridw1 = BoatAvailPrice.create(boat: ingrid, period_start: '2012-10-06', period_end: '2012-10-13', period_price: '3000', period_nights: 7)
ingridw2 = BoatAvailPrice.create(boat: ingrid, period_start: '2012-10-13', period_end: '2012-10-20', period_price: '2500', period_nights: 7)
ingridw3 = BoatAvailPrice.create(boat: ingrid, period_start: '2012-10-20', period_end: '2012-10-27', period_price: '3200', period_nights: 7)
ingridw5 = BoatAvailPrice.create(boat: ingrid, period_start: '2012-10-27', period_end: '2012-11-03', period_price: '3500', period_nights: 7)

mirandadw1 = BoatAvailPrice.create(boat: miranda, period_start: '2012-10-13', period_end: '2012-10-20', period_price: '2500', period_nights: 7)
mirandadw2 = BoatAvailPrice.create(boat: miranda, period_start: '2012-10-20', period_end: '2012-10-27', period_price: '3200', period_nights: 7)

lisadw1 = BoatAvailPrice.create(boat: lisa, period_start: '2012-10-06', period_end: '2012-10-13', period_price: '3000', period_nights: 7)
lisadw2 = BoatAvailPrice.create(boat: lisa, period_start: '2012-10-13', period_end: '2012-10-20', period_price: '2500', period_nights: 7)

gps = StandardAttribute.create(description: 'GPS Navigation System', valuetype: 'boolean')
gpsstring = StandardAttributeMatch.create(standard_attribute: gps, matcher: 'gps')

mp3 = StandardAttribute.create(description: 'MP3 Player', valuetype: 'boolean')
mp3string = StandardAttributeMatch.create(standard_attribute: mp3, matcher: 'mp3')

color = StandardAttribute.create(description: 'Color', valuetype: 'string')
colorstring = StandardAttributeMatch.create(standard_attribute: color, matcher: 'color')

ac = StandardAttribute.create(description: 'Air Conditioning', valuetype: 'integer')
acstring = StandardAttributeMatch.create(standard_attribute: ac, matcher: 'ac')

ingridgps = BoatAttribute.create(boat: ingrid, description: 'GPS System', value: 'true')
ingridgpsstd = BoatAttributeStandardValue.create(boat_attribute: ingridgps, standard_attribute: gps, value: 'true')
ingridmp3 = BoatAttribute.create(boat: ingrid, description: 'MP3 Player', value: 'true')
ingridmp3std = BoatAttributeStandardValue.create(boat_attribute: ingridmp3, standard_attribute: mp3, value: 'true')
ingridcolor = BoatAttribute.create(boat: ingrid, description: 'Color', value: 'white')
ingridcolorstd = BoatAttributeStandardValue.create(boat_attribute: ingridcolor, standard_attribute: color, value: 'white')
ingridac = BoatAttribute.create(boat: ingrid, description: 'Air Conditioning', value: '1')
ingridacstd = BoatAttributeStandardValue.create(boat_attribute: ingridac, standard_attribute: ac, value: '1')

lisagps = BoatAttribute.create(boat: lisa, description: 'GPS System', value: 'true')
lisagpsstd = BoatAttributeStandardValue.create(boat_attribute: lisagps, standard_attribute: gps, value: 'true')
lisacolor = BoatAttribute.create(boat: lisa, description: 'Color', value: 'black')
lisacolorstd = BoatAttributeStandardValue.create(boat_attribute: lisacolor, standard_attribute: color, value: 'black')
lisaac = BoatAttribute.create(boat: lisa, description: 'Air Conditioning', value: '2')
lisaacstd = BoatAttributeStandardValue.create(boat_attribute: lisaac, standard_attribute: ac, value: '2')

mirandamp3 = BoatAttribute.create(boat: miranda, description: 'MP3 Player', value: 'true')
mirandamp3std = BoatAttributeStandardValue.create(boat_attribute: mirandamp3, standard_attribute: mp3, value: 'true')
mirandacolor = BoatAttribute.create(boat: miranda, description: 'Color', value: 'white')
mirandacolorstd = BoatAttributeStandardValue.create(boat_attribute: mirandacolor, standard_attribute: color, value: 'white')
mirandaac = BoatAttribute.create(boat: miranda, description: 'Air Conditioning', value: '3')
mirandaacstd = BoatAttributeStandardValue.create(boat_attribute: mirandaac, standard_attribute: ac, value: '3')

region1 = Region.create(:name => 'Kordun')
region2 = Region.create(:name => 'Lika')
region3 = Region.create(:name => 'Istria')

region_marinas1 = Marina.first.regions << Region.first
region_marinas2 = Marina.first.regions << Region.find(3)
region_marinas2 = Marina.all[1].regions << Region.find(2)