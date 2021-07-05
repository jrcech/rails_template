# frozen_string_literal: true

module Table
  module Row
    class Component < ViewComponent::Base
      include Utilities::PathsHelper
      include Utilities::ResourceHelper
      include Utilities::ModelHelper
      include Utilities::ControllerHelper
      include Utilities::FontAwesomeHelper

      with_collection_parameter :row

      # renders_many :cells, lambda { |cells1:, header:|
      #   content_tag header.present? ? :th : :td do
      #     Table::Cell::Component.new cell: cells1
      #   end
      # }

      def initialize(row:, head: false)
        @row = row
        @head = head
      end

      private

      attr_reader :row, :head
    end
  end
end
