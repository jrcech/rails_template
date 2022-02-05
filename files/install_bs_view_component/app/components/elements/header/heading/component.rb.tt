# frozen_string_literal: true

module Elements
  module Header
    module Heading
      class Component < ViewComponent::Base
        include Utilities::PathsHelper
        include Utilities::ResourceHelper
        include Utilities::ModelHelper
        include Utilities::ControllerHelper
        include Utilities::FontAwesomeHelper

        def initialize(header:, main_header:)
          @header = header
          @main_header = main_header
        end

        private

        attr_reader :header, :main_header
      end
    end
  end
end
