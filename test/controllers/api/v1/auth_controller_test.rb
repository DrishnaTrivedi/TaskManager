require "test_helper"

class Api::V1::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_v1_auth_login_url
    assert_response :success
  end
end
