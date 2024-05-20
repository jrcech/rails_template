module Headers
  class SearchFormComponent < ViewComponent::Base
    def initialize(search_query:, search_form:, path_for_search:, model:)
      super

      @search_query = search_query
      @search_form = search_form
      @path_for_search = path_for_search
      @model = model
    end

    def render?
      search_form.present?
    end

    private

    attr_reader :search_query, :search_form, :path_for_search, :model
  end
end
