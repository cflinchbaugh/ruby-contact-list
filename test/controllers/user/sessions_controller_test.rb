require "test_helper"

class User::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)  # This user is confirmed in the fixture
    @unconfirmed_user = users(:unconfirmed_user)  # Assuming you have an unconfirmed user fixture or factory
  end

  test "should not allow login for unconfirmed user" do
    post user_session_path, params: { user: { email: @unconfirmed_user.email, password: "password" } }

    # Check that we get a 401 Unauthorized status, indicating login failure
    assert_response :unauthorized
  end
end
