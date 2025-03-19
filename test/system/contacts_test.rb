require "application_system_test_case"

class ContactsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in @user

    @contact = contacts(:two)
  end

  test "visiting the index" do
    visit contacts_url
    assert_selector "h1", text: "Contacts"
  end

  test "should create contact" do
    visit contacts_url
    click_on "Add New Contact"

    fill_in "Email", with: @contact.email
    fill_in "First name", with: @contact.first_name
    fill_in "Last name", with: @contact.last_name
    fill_in "Phone", with: @contact.phone
    click_on "Create Contact"

    assert_text "Contact was successfully created"
    click_on "Back"
  end

  test "should update Contact" do
    visit contact_url(@contact)

    #  Target the Edit link rather than the "Edit Profile" in navbar
    find("[data-contact-id='#{@contact.id}'] a", text: "Edit").click

    puts "Current Contact: #{@contact.inspect}"

    fill_in "Email", with: @contact.email
    fill_in "First name", with: @contact.first_name
    fill_in "Last name", with: @contact.last_name
    fill_in "Phone", with: @contact.phone
    click_on "Update Contact"

    assert_text "Contact was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact" do
    visit contact_url(@contact)
    click_on "Delete", match: :first

    assert_text "Contact was successfully deleted"
  end
end
