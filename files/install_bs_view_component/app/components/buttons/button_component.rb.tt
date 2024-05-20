module Buttons
  class ButtonComponent < ViewComponent::Base
    with_collection_parameter :button

    def initialize(**button)
      super

      @button = button

      sanitize_button
    end

    private

    attr_reader :button

    def sanitize_button
      @button = button_attributes.merge(button.except(:button))
    end

    def button_attributes
      return button[:button] if from_collection?

      button
    end

    def from_collection?
      button.key?(:button)
    end
  end
end
