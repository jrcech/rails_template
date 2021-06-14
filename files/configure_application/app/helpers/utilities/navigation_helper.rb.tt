# frozen_string_literal: true

module Utilities
  module NavigationHelper
    attr_reader :nav_item

    def active_class
      return ' active' if active?

      nil
    end

    def active?
      return true if controller_name == nav_item[:controller]

      false
    end
  end
end
