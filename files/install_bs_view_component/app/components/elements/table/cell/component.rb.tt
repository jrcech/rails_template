# frozen_string_literal: true

module Elements
  module Table
    module Cell
      class Component < ViewComponent::Base
        include Utilities::PathsHelper
        include Utilities::ResourceHelper
        include Utilities::ModelHelper
        include Utilities::ControllerHelper
        include Utilities::FontAwesomeHelper

        with_collection_parameter :cell

        def initialize(cell:, cell_iteration:, thead: nil, buttons: nil)
          @cell = cell
          @cell_iteration = cell_iteration
          @thead = thead
          @buttons = buttons
        end

        private

        attr_reader :cell, :cell_iteration, :thead, :buttons

        def cell_element
          return :th if thead.present?

          :td
        end

        def cell_attributes
          return { scope: 'col' } if thead.present?

          nil
        end

        def cell_content
          return cell if buttons.present? && cell_iteration.last?

          content_tag :span, cell
        end
      end
    end
  end
end
