module Buttons
  class LinkComponent < ViewComponent::Base
    def initialize(**button)
      super

      @button = button
    end

    private

    attr_reader :button

    def construct_title
      return button[:title] if button[:icon].blank?

      render(
        Icons::FontAwesomeComponent.new(
          icon: button[:icon],
          title: button[:title],
          text: button[:title]
        )
      )
    end

    def construct_class
      return button[:button_class] if button.key?(:button_class)

      'btn btn-primary'
    end
  end
end
