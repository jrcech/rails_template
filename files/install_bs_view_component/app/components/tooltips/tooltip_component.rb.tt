module Tooltips
  class TooltipComponent < ViewComponent::Base
    def initialize(icon:, title:, **options)
      super

      @icon = icon
      @title = title
      @options = options
    end

    private

    attr_reader :icon, :title, :options

    def construct_options
      options.deep_merge(construct_data)
    end

    def construct_data
      hash = {
        data: {
          bs_target: :tooltip
        }
      }

      hash[:data][:bs_placement] = placement if placement?

      hash
    end

    def placement
      return options[:placement] if placement?

      nil
    end

    def placement?
      options&.dig(:placement).present?
    end
  end
end
