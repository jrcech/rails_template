module Navs
  class NavComponent < ViewComponent::Base
    def initialize(nav_items:, **options)
      super

      @nav_items = alter_nav_items(nav_items)
      @options = options
    end

    private

    attr_reader :nav_items, :options

    def alter_nav_items(nav_items)
      nav_items.each do |button|
        button[:button_class] = merge_button_class(**button)
      end
    end

    def merge_button_class(**button)
      return button[:button_class] if button.key?(:button_class)

      'nav-link'
    end

    def nav_attributes
      {
        class: construct_class,
        id: construct_id
      }
    end

    def construct_class
      return navbar_class if navbar?

      'nav'
    end

    def navbar_class
      "navbar-nav#{left_nav_class}"
    end

    def left_nav_class
      return ' me-auto' if left_nav?

      nil
    end

    def left_nav?
      options&.dig(:type) == :left_nav
    end

    def navbar?
      options&.dig(:navbar)
    end

    def construct_id
      options&.dig(:id)
    end
  end
end
