# frozen_string_literal: true

module Elements
  module Header
    class Component < ViewComponent::Base
      include Utilities::PathsHelper
      include Utilities::ResourceHelper
      include Utilities::ModelHelper
      include Utilities::ControllerHelper
      include Utilities::FontAwesomeHelper

      def initialize(header:, main_header:, item: nil, **options)
        @header = header
        @main_header = main_header
        @item = item
        @options = options
        @search_form = options.key? :search_query
      end

      private

      attr_reader(
        :header,
        :main_header,
        :item,
        :options,
        :search_form
      )
    end
  end
end
