# frozen_string_literal: true

module Elements
  module Table
    class Component < ViewComponent::Base
      include ViewDecorator
      include Utilities::FontAwesomeHelper

      def initialize(items:, tbody:, thead: nil, buttons: nil, search_query: nil)
        @items = items
        @tbody = tbody
        @thead = thead
        @buttons = buttons
        @search_query = search_query
      end

      def items_collection
        collection = []

        items.each do |item|
          item_presenter_class = "#{item.class}Presenter"
          item_presenter = item_presenter_class.constantize.new(
            item: item, search_query: search_query
          )

          cells = item_cells(item, item_presenter)

          cells << index_buttons(item, item_presenter) if buttons.present?

          collection << { cells: cells, show_path: path_for(:show, item) }
        end

        collection
      end

      private

      attr_reader :thead, :tbody, :items, :search_query, :buttons

      def item_cells(item, item_presenter)
        cells = []

        tbody.each do |cell|
          cells << eval_cell(item, cell, item_presenter)
        end

        cells
      end

      def eval_cell(item, cell, item_presenter)
        case cell
          # when Array
          #   cell.inject(item, :send)
        when Hash
          custom_presenter = cell.keys.first.to_s.classify.constantize
          method = cell.values.first

          custom_presenter.new(
            item: item,
            search_query: search_query
          ).send(method)
          # send(cell.keys.first, item.send(cell.values.first), search_query)
        else
          item_presenter.send(cell)
        end
      end

      def index_buttons(item, item_presenter)
        render Buttons::Dropdown::Component.new(
          item: item,
          id: item_presenter.title,
          dropdown_items: buttons.first[:ellipsis_button]
        )
      end
    end
  end
end
