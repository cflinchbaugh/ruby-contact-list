require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
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
end
