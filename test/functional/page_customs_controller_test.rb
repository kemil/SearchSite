require 'test_helper'

class PageCustomsControllerTest < ActionController::TestCase

	test "redirect page" do
    get :show, :url =>"redirect_me"
    assert_response :redirect
    assert_redirected_to assigns(:page).redirect
	end

	test "content page and markdown support" do
    get :show, :url =>"content_me"
    assert_response :success
	end

	test "404 should redirect" do
    get :show, :url =>"doesntexist"
    assert_response :redirect
	end


end
