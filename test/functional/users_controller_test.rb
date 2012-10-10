require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "save email address as user on newsletter signup" do
  	@request.env["devise.mapping"] = Devise.mappings[:user]
    put(:create, :user => {:email => 'badabing@inipix.com'})
    assert_equal 1, User.find_all_by_email("badabing@inipix.com").count
  end


end
