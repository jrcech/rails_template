module Icons
  class FontAwesomeComponent < ViewComponent::Base
    def initialize(icon:, title:, **options)
      super

      @icon = icon
      @title = title
      @options = options
    end

    private

    attr_reader :icon, :title, :options

    def construct_class
      "#{style}#{construct_icon}#{size}#{fixed_width}" +
        +"#{animation}#{rotation}#{border}#{pull}"
    end

    def construct_data
      return { controller: 'font-awesome' } if options&.dig(:data).blank?

      hash = options[:data]
      hash[:controller] = construct_controller

      hash
    end

    def construct_controller
      controller = options[:data][:controller]

      return 'font-awesome' if controller.blank?

      "font-awesome #{controller}"
    end

    def style
      style = options&.dig :style

      return style if style.present?

      'fa-solid'
    end

    def construct_icon
      " fa-#{icon}"
    end

    def size
      size = options&.dig :size

      return " fa-#{size}" if size.present?

      nil
    end

    def animation
      animation = options&.dig :animation

      return " fa-#{animation}" if animation.present?

      nil
    end

    def fixed_width
      return ' fa-fw' if options&.dig(:fixed_width) || options&.dig(:text)

      nil
    end

    def rotation
      rotation = options&.dig :rotation

      return " fa-#{rotation}" if rotation.present?

      nil
    end

    def border
      return ' fa-border' if options&.dig :border

      nil
    end

    def pull
      position = options&.dig :pull

      return " fa-pull-#{position}" if position.present?

      nil
    end
  end
end
