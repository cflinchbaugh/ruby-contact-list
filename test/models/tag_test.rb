require "test_helper"

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.new(name: "Work")
  end

  test "should be valid with a name" do
    assert @tag.valid?
  end

  test "should not be valid without a name" do
    @tag.name = ""
    assert_not @tag.valid?
  end

  test "should have many contacts through contact_tags" do
    assert_respond_to @tag, :contacts
  end
end
