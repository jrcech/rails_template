# frozen_string_literal: true

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--window-size=1920,1080')
  options.add_argument('--headless')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: options
  )
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
