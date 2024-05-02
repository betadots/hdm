require "application_system_test_case"

class AccessNodesKeysTest < ApplicationSystemTestCase
  setup do
    Rails.configuration.hdm[:authentication_disabled] = true
  end

  teardown do
    Rails.configuration.hdm[:authentication_disabled] = false
  end

  test "accessing a key of a node" do
    visit root_url

    click_on "Show Environments"

    slim_select "development", from: "environment"

    slim_select "testhost (development)", from: "node"

    click_on "hdm::integer"

    click_on "common.yaml"

    assert has_css?("textarea[name=value]", text: "1")
  end
end
