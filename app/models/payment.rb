class Payment < ActiveRecord::Base
	belongs_to :invoice


	def get_dibs_conf(type, amount)
		dibsamount = (amount * 100).to_i.to_s # 100 = 1.00
		invoicename = self.invoice.identifier
	
		conf = {
			:merchant => "etv",
			:secret_key => "9880970D2CAFA478B3C5C973BC47B7C8564E4103",
			:fields => {
				:method => "cc.test", # Test by default
				:currency => 'EUR',
				:amount => dibsamount, 
				:authOnly => false, # makes us capture immediately
				:pageSet => 'yaf',
				:data => "1:Payment on invoice #{invoicename}:1:#{dibsamount}:", # item, name, quantity, price
				:uses3dsecure => true,
				:billingFirstName => self.invoice.trip.customer.namefirst,
        :billingLastName => self.invoice.trip.customer.namelast,
        :billingAddress => self.invoice.trip.customer.address1,
        :billingCity => self.invoice.trip.customer.town,
        :billingCountry => self.invoice.trip.customer.country.isocode,
        :eMail => self.invoice.trip.customer.email,
        :referenceNo => invoicename + "-#{self.invoice.payments.count+1}", # this is used for mac - use our invoice order or something
        :invoiceNo => invoicename,
        :customerNo => "YAF-" + self.invoice.trip.customer.id.to_s
			}
		}
		
		conf[:fields][:method] = 'cc.cekab' if type == 'CC'
		conf[:fields][:method] = 'cc.nw' if type == 'AX'
		
		conf
	end


end
