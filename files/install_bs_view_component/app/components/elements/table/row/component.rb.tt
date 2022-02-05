# frozen_string_literal: true

module Elements
  module Table
    module Row
      class Component < ViewComponent::Base
        include Utilities::PathsHelper
        include Utilities::ResourceHelper
        include Utilities::ModelHelper
        include Utilities::ControllerHelper
        include Utilities::FontAwesomeHelper

        with_collection_parameter :row

        def initialize(row:, thead: nil, buttons: nil)
          case row
          when Hash
            @row = row[:cells]
            @show_path = row[:show_path]
          else
            @row = row
          end

          @thead = thead
          @buttons = buttons
        end

        private

        attr_reader :row, :thead, :buttons, :show_path

        def tr_attributes
          return nil if thead.present?

          {
            data: {
              controller: 'index-table',
              action: 'click->index-table#visit',
              'index-table-link': show_path
            }
          }
        end
      end
    end
  end
end
