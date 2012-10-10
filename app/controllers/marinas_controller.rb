
class MarinasController < ApplicationController
  respond_to :json

  def autocomplete
    term = params[:term]
    term = '' if term.nil?
    term = term.strip

    if term == ''
      render :json => []
      return
    end

    result = Marina.find_names(term)

    render :json => result
  end
end