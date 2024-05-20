module Helpers
  module CssAttributesMatchers
    def expect_to_have_css_attributes(expected_attributes)
      expected_attributes.each do |attribute|
        expect(page).to have_css attribute
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::CssAttributesMatchers
end
