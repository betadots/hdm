require "application_system_test_case"

class PuppetNodesTest < ApplicationSystemTestCase
  setup do
    @puppet_node = puppet_nodes(:one)
  end

  test "visiting the index" do
    visit puppet_nodes_url
    assert_selector "h1", text: "Puppet Nodes"
  end

  test "creating a Puppet node" do
    visit puppet_nodes_url
    click_on "New Puppet Node"

    fill_in "Config file name", with: @puppet_node.config_file_name
    fill_in "Fqdn", with: @puppet_node.fqdn
    fill_in "Organization", with: @puppet_node.organization
    fill_in "Os family", with: @puppet_node.os_family
    fill_in "Os lsbdistcodename", with: @puppet_node.os_lsbdistcodename
    fill_in "Puppet environment", with: @puppet_node.puppet_environment_id
    fill_in "Role", with: @puppet_node.role
    fill_in "Zone", with: @puppet_node.zone
    click_on "Create Puppet node"

    assert_text "Puppet node was successfully created"
    click_on "Back"
  end

  test "updating a Puppet node" do
    visit puppet_nodes_url
    click_on "Edit", match: :first

    fill_in "Config file name", with: @puppet_node.config_file_name
    fill_in "Fqdn", with: @puppet_node.fqdn
    fill_in "Organization", with: @puppet_node.organization
    fill_in "Os family", with: @puppet_node.os_family
    fill_in "Os lsbdistcodename", with: @puppet_node.os_lsbdistcodename
    fill_in "Puppet environment", with: @puppet_node.puppet_environment_id
    fill_in "Role", with: @puppet_node.role
    fill_in "Zone", with: @puppet_node.zone
    click_on "Update Puppet node"

    assert_text "Puppet node was successfully updated"
    click_on "Back"
  end

  test "destroying a Puppet node" do
    visit puppet_nodes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Puppet node was successfully destroyed"
  end
end
