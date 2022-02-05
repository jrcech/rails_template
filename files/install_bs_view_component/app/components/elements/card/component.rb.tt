# frozen_string_literal: true

module Elements
  module Card
    class Component < ViewComponent::Base
      include Utilities::ModelHelper
      include Utilities::FontAwesomeHelper
      include Utilities::TooltipHelper

      def initialize(item:, item_presenter:, details:)
        @item = item
        @item_presenter = item_presenter
        @details = details
      end

      private

      attr_reader :item, :item_presenter, :details
    end
  end
end
