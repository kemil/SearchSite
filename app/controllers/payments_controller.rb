require 'digest/md5'

class PaymentsController < ApplicationController

  def pay
  	invoice = Invoice.find_by_identifier(params[:invoice])
  	type = params[:type]
  	amount = BigDecimal(params[:amount])
  
  	if invoice != nil and type != nil and amount > 0
  		payment = invoice.payments.build()
  		conf = payment.get_dibs_conf(type, amount)
		
			# the Debitch gem uses SHA1 while our account uses MD5 so override that!
			@mac = Digest::MD5.hexdigest(conf[:fields][:data] + "&" + conf[:fields][:currency] + "&"+ conf[:fields][:referenceNo] + "&" + conf[:secret_key] + "&").upcase
			@api = Debitech::WebApi.new(conf)
  	end
  end
  
  def arrive
  	@invoice = Invoice.find_by_identifier(params[:invoice])
  	@reply = params[:reply]
  
  	if @invoice != nil && @invoice.trip != nil
  		redirect_to trip_path(@invoice.trip)
  	else
  		redirect_to "/"
  	end
  end



	# /pay/callback/[ver valueof="invoiceNo"]/[ver sum]/[ver valueof="currency"]/[ver reply]/[ver id no]/[ver MAC]
	# 'pay/callback/:invoice/:sum/:currency/:reply/:id/:mac'
	# approved example: /pay/callback/LYNRCVET-1/1,00/EUR/A/156370514/MAC=9804AA111B64168F3A48BF813A482E90 
	# denied example: /pay/callback/LHIOCMRS-1/1,00/EUR/D/156372392/MAC=8BB740371255D96FDC20EED59762F644 
	def callback
  	invoice = Invoice.find_by_identifier(params[:invoice])

  	if invoice != nil
			sum = params[:sum]
			currency = params[:currency]
			reply = params[:reply] # A - accepted D - denied
			id = params[:id]
			mac = params[:mac].gsub "MAC=", "" # MAC=9804AA111B64168F3A48BF813A482E90
			secret = "9880970D2CAFA478B3C5C973BC47B7C8564E4103"
			ref =  invoice.identifier + "-#{invoice.payments.count+1}"
	
			# MD5(sum&currency&reply&id no&referenceNo&SecretKey&)
			@verifymac = Digest::MD5.hexdigest(sum + "&" + currency + "&"+ reply + "&" + id + "&" + ref + "&" + secret + "&").upcase
			
			logger.debug "Incoming MAC: #{mac} (#{params[:mac]}) Calculated MAC: #{@verifymac}"
			
			if reply == 'A' and mac == @verifymac
	  		payment = invoice.payments.build(:psp => 'debitech', :externalref => id, :amount => sum, :currency => currency)
	  		payment.save
			end
  	end
	end

end
