require "test_helper"

class ContactTagTest < ActiveSupport::TestCase
  def setup
    @contact = contacts(:one)
    @tag = tags(:one)
    @contact_tag = ContactTag.new(contact: @contact, tag: @tag)
  end

  test "should be valid with valid attributes" do
    assert @contact_tag.valid?
  end

  test "should require a contact" do
    @contact_tag.contact = nil
    assert_not @contact_tag.valid?
  end

  test "should require a tag" do
    @contact_tag.tag = nil
    assert_not @contact_tag.valid?
  end
end
