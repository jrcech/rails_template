# frozen_string_literal: true

module Elements
  module Header
    module PagyInfo
      class Component < ViewComponent::Base
        include Utilities::PathsHelper
        include Utilities::ResourceHelper
        include Utilities::ModelHelper
        include Utilities::ControllerHelper
        include Utilities::FontAwesomeHelper
        include Pagy::Frontend

        def initialize(pagy:)
          @pagy = pagy
        end

        def render?
          pagy.present? && action_name != 'show'
        end

        private

        attr_reader :pagy
      end
    end
  end
end
