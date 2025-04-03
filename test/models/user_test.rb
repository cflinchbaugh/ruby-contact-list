require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)  # This user is confirmed in the fixture
    @unconfirmed_user = users(:unconfirmed_user)  # This user is unconfirmed in the fixture
  end

  test "should be valid with email and password" do
    assert @user.valid?
  end

  test "should have many contacts" do
    assert_respond_to @user, :contacts
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = ""
    @user.password_confirmation = ""
    assert_not @user.valid?
  end

  test "should allow login for confirmed user" do
    sign_in @user  # Ensure the user can sign in because they are confirmed
    assert @user.confirmed_at.present?
  end
end
