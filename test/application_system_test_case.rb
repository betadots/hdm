require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  private

  def slim_select(value, from:)
    select = find("select[name=\"#{from}\"]", visible: false)
    slim_select_main = select.sibling("div[class=ss-main]")
    slim_select_main.click
    option = find("div[class=ss-option]", text: value)
    option.click
    page.has_css?("div[class=ss-single]", text: value)
  end
end
