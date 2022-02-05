# frozen_string_literal: true

module Elements
  module Buttons
    module Dropdown
      class Component < ViewComponent::Base
        include Buttons::Dropdown::Presets

        def initialize(dropdown_items: nil, item: nil, **dropdown)
          @dropdown_items = dropdown_items
          @item = item
          @dropdown = dropdown
        end

        private

        attr_reader :dropdown, :dropdown_items, :item

        def dropdown_button
          dropdown_hash = default_dropdown_hash

          dropdown_hash.merge! dropdown[:preset] if dropdown[:preset].present?
          dropdown_hash.merge! dropdown

          dropdown_hash.merge!({ id: dropdown_button_id })
        end

        def nav_item?
          return true if dropdown[:kind] == :nav_item

          false
        end

        def dropdown_element
          return :li if nav_item?

          :div
        end

        def dropdown_class
          return 'nav-item dropdown' if nav_item?

          'dropdown'
        end

        def dropdown_menu_position
          menu_position = dropdown[:menu_position]

          return " dropdown-menu-#{menu_position.to_s}" if menu_position.present?

          nil
        end

        def default_dropdown_hash
          {
            path: '#',
            class: default_dropdown_button_class,
            icon: default_dropdown_icon,
            aria_expanded: false,
            title: dropdown[:title],
            data: {
              bs_toggle: 'dropdown'
            }
          }
        end

        def default_dropdown_button_class
          return 'nav-link dropdown-toggle' if nav_item?

          'btn btn-light'
        end

        def default_dropdown_icon
          return nil if nav_item?

          'ellipsis-h'
        end

        def dropdown_button_id
          button_id = +''
          button_id << "#{create_id}-" if title? || id?
          button_id << 'dropdown-button'
        end

        def create_id
          string = +''
          string << dropdown[:title] if title?
          string << dropdown[:id] if id?

          I18n.transliterate(string).parameterize
        end

        def title?
          dropdown[:title].present?
        end

        def id?
          dropdown[:id].present?
        end
      end
    end
  end
end
