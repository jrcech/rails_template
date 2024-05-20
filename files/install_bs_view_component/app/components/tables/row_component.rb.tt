module Tables
  class RowComponent < ViewComponent::Base
    with_collection_parameter :row

    def initialize(row:, cell_element: nil, cell_attributes: nil)
      super

      @row = row
      @cell_element = cell_element
      @cell_attributes = cell_attributes
    end

    private

    attr_reader :row, :cell_element, :cell_attributes

    def tr_attributes
      return click_row_attributes if row[:show_path].present?

      nil
    end

    def click_row_attributes
      {
        role: 'button',
        data: {
          controller: 'index-table',
          action: 'click->index-table#visit',
          'index-table-link': row[:show_path]
        }
      }
    end
  end
end
