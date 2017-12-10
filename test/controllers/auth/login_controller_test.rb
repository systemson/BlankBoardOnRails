require 'test_helper'

class Auth::LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get auth_login_login_url
    assert_response :success
  end

  test "should get register" do
    get auth_login_register_url
    assert_response :success
  end

end
