require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @contact = contacts(:one)
  end

  test "should be valid with all attributes and user" do
    assert @contact.valid?
  end

  test "should require a user" do
    @contact.user = nil
    assert_not @contact.valid?
  end

  test "should have many contact_tags" do
    assert_respond_to @contact, :contact_tags
  end

  test "should have many tags through contact_tags" do
    assert_respond_to @contact, :tags
  end
end
