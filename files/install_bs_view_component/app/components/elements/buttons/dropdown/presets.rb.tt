# frozen_string_literal: true

module Elements
  module Buttons
    module Dropdown
      module Presets
        private

        def ellipsis_button
          {
            class: 'btn btn-light',
            icon: 'ellipsis-v'
          }
        end

        def test_button
          {
            class: 'btn btn-secondary',
            icon: 'check'
          }
        end

        def per_page_button
          {
            class: 'btn btn-light dropdown-toggle',
            icon: nil,
            title: "#{pagy.vars[:items]} items per page",
          }
        end

        def per_page_dropdown_items
          per_page_items = []

          pagy.vars[:per_page].each do |per_page|
            path = request.params.merge({ items: per_page, page: 1 })

            per_page_item = { title: per_page, path: path }

            per_page_items << per_page_item
          end

          per_page_items
        end
      end
    end
  end
end
