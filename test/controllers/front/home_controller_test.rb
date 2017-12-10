require 'test_helper'

class Front::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get front_home_index_url
    assert_response :success
  end

end
