class InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find_by_identifier(params[:id])
  end

end
