module Cards
  class CardComponent < ViewComponent::Base
    def initialize(item:, item_presenter:, details:)
      super

      @item = item
      @item_presenter = item_presenter
      @details = details
    end

    private

    attr_reader :item, :item_presenter, :details
  end
end
