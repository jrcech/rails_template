module Headers
  class HeaderComponent < ViewComponent::Base
    def initialize(header:, main_header:, item: nil, **options)
      super

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
