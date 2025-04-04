require "test_helper"

class User::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)  # This user is confirmed in the fixture
    @user.password = "password"
    @user.password_confirmation = "password"
    @user.save!  # Save the user so that the password is encrypted

    @unconfirmed_user = users(:unconfirmed_user)  # Assuming you have an unconfirmed user fixture or factory
  end

  test "should allow login for confirmed user" do
    post user_session_path, params: { user: { email: @user.email, password: "password" } }

    # Check that the response is a redirect (302)
    assert_response :redirect

    # Ensure the redirection happens to the correct path (root path, in this case)
    follow_redirect!
    assert_response :success
    assert_select "div", text: "Signed in successfully."
  end

  test "should not allow login for unconfirmed user" do
    post user_session_path, params: { user: { email: @unconfirmed_user.email, password: "password" } }

    # Check that we get a 401 Unauthorized status, indicating login failure
    assert_response :unauthorized
  end
end
