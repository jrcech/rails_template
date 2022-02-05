# frozen_string_literal: true

module Elements
  module Table
    module Head
      class Component < ViewComponent::Base
        include Utilities::PathsHelper
        include Utilities::ResourceHelper
        include Utilities::ModelHelper
        include Utilities::ControllerHelper
        include Utilities::FontAwesomeHelper

        def initialize(thead:, buttons: nil)
          @thead = thead
          @buttons = buttons
        end

        def render?
          thead.present?
        end

        private

        attr_reader :thead, :buttons
      end
    end
  end
end
