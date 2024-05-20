module Footers
  class FooterComponent < ViewComponent::Base
    include Pagy::Frontend

    def initialize(left_dropdown: nil, pagination: nil)
      super

      @left_dropdown = left_dropdown
      @pagination = pagination
    end

    private

    attr_reader :left_dropdown, :pagination

    def left_dropdown?
      left_dropdown.present?
    end

    def pagination?
      pagination.present?
    end
  end
end
