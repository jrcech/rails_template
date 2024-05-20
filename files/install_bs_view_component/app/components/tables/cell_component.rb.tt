module Tables
  class CellComponent < ViewComponent::Base
    with_collection_parameter :cell

    def initialize(cell:, cell_element: nil, cell_attributes: nil)
      super

      @cell = cell
      @cell_element = cell_element
      @cell_attributes = cell_attributes
    end

    private

    attr_reader :cell, :cell_element, :cell_attributes

    def alter_element
      return cell_element if cell_element.present?

      :td
    end
  end
end
