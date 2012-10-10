require 'test_helper'
require 'json'

class Api::V1::BaseTest < ActionController::TestCase
  
  protected 
  
  def setup_request_default
    supplier1 = suppliers(:supplier1)
    setup_request( supplier1 )
  end
  
  def setup_request(supplier)
    access_token = supplier.access_token
    @request.env['API-Key'] = supplier.access_token
  end
end
