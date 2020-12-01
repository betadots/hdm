require "application_system_test_case"

class PuppetEnvironmentsTest < ApplicationSystemTestCase
  setup do
    @puppet_environment = puppet_environments(:one)
  end

  test "visiting the index" do
    visit puppet_environments_url
    assert_selector "h1", text: "Puppet Environments"
  end

  test "creating a Puppet environment" do
    visit puppet_environments_url
    click_on "New Puppet Environment"

    fill_in "Name", with: @puppet_environment.name
    click_on "Create Puppet environment"

    assert_text "Puppet environment was successfully created"
    click_on "Back"
  end

  test "updating a Puppet environment" do
    visit puppet_environments_url
    click_on "Edit", match: :first

    fill_in "Name", with: @puppet_environment.name
    click_on "Update Puppet environment"

    assert_text "Puppet environment was successfully updated"
    click_on "Back"
  end

  test "destroying a Puppet environment" do
    visit puppet_environments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Puppet environment was successfully destroyed"
  end
end
