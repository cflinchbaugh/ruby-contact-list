require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end


  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get about" do
    get home_about_url
    assert_response :success
  end
end
