class PageCustomsController < ApplicationController

	def show
		@page = PageCustom.find_by_url(params[:url])

		if not @page.nil?
			if @page.redirect != nil and @page.redirect != ''
				logger.debug "page is a redirect to #{@page.redirect}"
				redirect_to @page.redirect
			else
				respond_to do |format|
					format.html
				end
			end
		else
			redirect_to :root
		end
	end

	def test

	end

end
