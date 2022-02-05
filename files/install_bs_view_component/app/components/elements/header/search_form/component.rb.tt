# frozen_string_literal: true

module Elements
  module Header
    module SearchForm
      class Component < ViewComponent::Base
        include Utilities::PathsHelper
        include Utilities::ResourceHelper
        include Utilities::ModelHelper
        include Utilities::ControllerHelper
        include Utilities::FontAwesomeHelper

        def initialize(search_query:, search_form:)
          @search_query = search_query
          @search_form = search_form
        end

        def render?
          search_form.present?
        end

        private

        attr_reader :search_query, :search_form
      end
    end
  end
end
