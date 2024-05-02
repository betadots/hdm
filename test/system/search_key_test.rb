require "application_system_test_case"

class SearchKeyTest < ApplicationSystemTestCase
  setup do
    Rails.configuration.hdm[:authentication_disabled] = true
  end

  teardown do
    Rails.configuration.hdm[:authentication_disabled] = false
  end

  test "searching for a key" do
    visit root_url

    click_on "Show Environments"

    slim_select "development", from: "environment"

    fill_in "key", with: "hdm::integer\n"

    assert has_css?("h2", text: "Search Results")

    click_on "Eyaml hierarchy"

    click_on Rails.root.join("test/fixtures/files/puppet/environments/development/data/common.yaml").to_s

    assert has_css?(".accordion-body pre", text: "1")
  end
end
