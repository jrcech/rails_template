# frozen_string_literal: true

module Elements
  module Footer
    class Component < ViewComponent::Base
      include Utilities::PathsHelper
      include Utilities::ResourceHelper
      include Utilities::ModelHelper
      include Utilities::ControllerHelper
      include Utilities::FontAwesomeHelper
      include Pagy::Frontend
      include Buttons::Dropdown::Presets

      def initialize(pagy:)
        @pagy = pagy
      end

      private

      attr_reader :pagy
    end
  end
end
