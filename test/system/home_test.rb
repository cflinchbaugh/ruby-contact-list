require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)

    sign_in @user
  end

  test "unauthenticated user is presented with links to sign up and sign in the main content" do
    sign_out @user  # Manually sign out for this specific test
    visit root_path

    assert_text "Sign Up"
    assert_text "Sign In"

    assert_no_text "View Contacts"
  end

  test "authenticated user is NOT presented with links to sign up and sign in the main content" do
    user = users(:one)

    login_as(user, scope: :user)
    visit root_path

    assert_no_text "Sign Up"
    assert_no_text "Sign In"

    assert_text "View Contacts"
  end
end
