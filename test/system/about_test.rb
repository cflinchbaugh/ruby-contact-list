require "application_system_test_case"

class AboutTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)

    sign_in @user
  end

  test "unauthenticated user is redirected to sign in" do
    sign_out @user  # Manually sign out for this specific test
    visit home_about_url

    # Ensure we are redirected to the sign-in page
    assert_current_path new_user_session_path
    assert_text "You need to sign in or sign up"
  end

  test "authenticated user is presented with main content" do
    user = users(:one)

    login_as(user, scope: :user)
    visit home_about_url

    assert_selector "h1", text: "About"
  end
end
