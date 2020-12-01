require "application_system_test_case"

class RolesTest < ApplicationSystemTestCase
  setup do
    @role = roles(:one)
  end

  test "visiting the index" do
    visit roles_url
    assert_selector "h1", text: "Roles"
  end

  test "creating a Role" do
    visit roles_url
    click_on "New Role"

    fill_in "Name", with: @role.name
    click_on "Create Role"

    assert_text "Role was successfully created"
    click_on "Back"
  end

  test "updating a Role" do
    visit roles_url
    click_on "Edit", match: :first

    fill_in "Name", with: @role.name
    click_on "Update Role"

    assert_text "Role was successfully updated"
    click_on "Back"
  end

  test "destroying a Role" do
    visit roles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Role was successfully destroyed"
  end
end
