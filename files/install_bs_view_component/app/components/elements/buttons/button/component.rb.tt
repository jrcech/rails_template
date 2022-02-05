# frozen_string_literal: true

module Elements
  module Buttons
    module Button
      class Component < ViewComponent::Base
        include Utilities::FontAwesomeHelper
        include ViewDecorator
        include Buttons::Button::Actions::Crud
        include Buttons::Button::Actions::Role

        with_collection_parameter :button

        def initialize(button:, type: nil, item: nil)
          @button = button
          @type = type
          @item = item
          @item_presenter = item.present? ? initialize_item_presenter : nil
        end

        def create_button
          @button = evaluate_button

          construct_button
        end

        private

        attr_reader :button, :type, :item, :item_presenter

        def initialize_item_presenter
          item_presenter_class = "#{item.class}Presenter"

          item_presenter_class.constantize.new(item: item)
        end

        def evaluate_button
          evaluated_button = button_hash
          evaluated_button.merge! icon_fixed_width: true if dropdown_item?

          evaluated_button
        end

        def button_hash
          return button if button.is_a? Hash || divider?

          send button
        end

        def dropdown_item?
          type == :dropdown_item
        end

        def nav_item?
          type == :nav_item
        end

        def divider?
          button == :divider
        end

        def construct_button
          link_to(
            title_with_icon,
            button[:path],
            method: button[:method],
            class: button_class,
            role: 'button',
            id: button[:id],
            'aria-expanded': button[:aria_expanded],
            data: button[:data]
          )
        end

        def title_with_icon
          return button[:title] if button[:icon].blank?

          fa_icon(
            button[:icon],
            text: button[:title],
            fixed_width: button[:icon_fixed_width]
          )
        end

        def button_class
          "#{construct_button_class}#{construct_dropdown_class}"
        end

        def construct_button_class
          return nil if dropdown_item?
          return 'nav-link' if nav_item?
          return button[:class] if button.key? :class
          return "btn btn-#{bootstrap_class}" if bootstrap_class.present?

          'btn btn-primary'
        end

        def construct_dropdown_class
          "#{dropdown_class}#{dropdown_color_class}"
        end

        def dropdown_class
          return nil unless dropdown_item?

          'dropdown-item'
        end

        def dropdown_color_class
          return nil unless dropdown_item?
          return " text-#{bootstrap_class}" if bootstrap_class.present?

          nil
        end

        def bootstrap_class
          {
            new: 'success',
            edit: 'primary',
            destroy: 'danger',
            make_admin: 'secondary',
            make_member: 'warning'
          }[button[:action]]
        end
      end
    end
  end
end
