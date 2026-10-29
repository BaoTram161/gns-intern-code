require "test_helper"

Capybara.register_driver :headless_chrome_docker do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.binary = "/usr/bin/chromium"
  options.add_argument("--headless=new")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-gpu")
  options.add_argument("--window-size=1400,1400")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :headless_chrome_docker
end