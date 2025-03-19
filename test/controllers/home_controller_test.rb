require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.find_or_create_by!(email: "user1@example.com") do |user|
      user.password = "password"
    end
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
