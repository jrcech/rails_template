# Capybara Configuration
#
# Purpose:
# Configures Capybara with Selenium drivers for different device breakpoints and headless mode.
#
# Default Behavior:
# - The default driver remains unchanged. Executing `bundle exec rspec` runs tests as before.
#
# Drivers:
# - Standard: :selenium_chrome_mobile, :selenium_chrome_tablet, :selenium_chrome_desktop
# - Headless: :selenium_chrome_mobile_headless, :selenium_chrome_tablet_headless, :selenium_chrome_desktop_headless
#
# Commands:
# - Default: `bundle exec rspec`
# - Device-specific: `DEVICE=<device_type> bundle exec rspec` (where `<device_type>` is mobile, tablet, or desktop)
# - Headless: `HEADLESS=true bundle exec rspec` for headless mode
#
# Test Usage (for dedicated device-specific tests):
# ```ruby
# describe 'feature', type: :system, driver: <selected_driver> do
#   # test content
# end
# ```
# Replace `<selected_driver>` with the desired driver, e.g., :selenium_chrome_mobile.
#

Capybara.default_driver = :selenium_chrome

DEVICE_BREAKPOINTS = {
  'mobile' => [640, 800],
  'tablet' => [768, 1024],
  'desktop' => [1024, 1366]
}.freeze

DEVICE_BREAKPOINTS.each do |device, size|
  Capybara.register_driver :"selenium_chrome_#{device}" do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("window-size=#{size[0]},#{size[1]}")

    Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  end

  Capybara.register_driver :"selenium_chrome_#{device}_headless" do |app|
    options = Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.add_argument('--headless')
      opts.add_argument('--no-sandbox')
      opts.add_argument('--disable-gpu')
      opts.add_argument('--disable-dev-shm-usage')
      opts.add_argument("--window-size=#{size[0]},#{size[1]}")
    end

    Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
  end
end

RSpec.configure do |config|
  config.before(:each, js: false, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system) do
    device = "_#{ENV['DEVICE']}" if ENV['DEVICE']
    headless = '_headless' if ENV['HEADLESS']

    driver = :"selenium_chrome#{device}#{headless}"

    driven_by driver
  end
end
