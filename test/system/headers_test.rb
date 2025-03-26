require "application_system_test_case"

class HeadersTest < ApplicationSystemTestCase
  setup do
    @user_without_avatar = users(:one)

    @user_with_avatar = users(:with_avatar)
    @user_with_avatar = users(:with_avatar)
    @user_with_avatar.avatar = File.open(Rails.root.join("test/fixtures/files/avatar.png"))
    @user_with_avatar.save!
  end

  test "shows email if user has no avatar" do
    login_as(@user_without_avatar)
    visit root_path

    assert_text @user_without_avatar.email
  end

  test "shows avatar image if user has one" do
    login_as(@user_with_avatar)
    visit root_path

    assert_selector("img.img-fluid.rounded-circle", count: 1)
  end

  test "shows sign out link if signed in" do
    login_as(@user_without_avatar)
    visit root_path

    assert_link "Sign Out"
  end

  test "shows sign in and sign up links if logged out" do
    visit root_path

    assert_link "Sign In"
    assert_link "Sign Up"
  end
end
