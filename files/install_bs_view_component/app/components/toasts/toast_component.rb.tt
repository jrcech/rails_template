module Toasts
  class ToastComponent < ViewComponent::Base
    TEXT_COLOR_CLASSES = {
      success: 'text-success',
      danger: 'text-danger',
      warning: 'text-warning',
      info: 'text-info'
    }.freeze

    BG_COLOR_CLASSES = {
      success: 'bg-success',
      danger: 'bg-danger',
      warning: 'bg-warning',
      info: 'bg-info'
    }.freeze

    ICONS = {
      success: 'check',
      danger: 'exclamation-triangle',
      warning: 'exclamation',
      info: 'info'
    }.freeze

    def initialize(flash:)
      super

      @flash = flash
    end

    private

    attr_reader :flash

    def text_color_class_for(type)
      TEXT_COLOR_CLASSES[type.to_sym] || 'text-info'
    end

    def bg_color_class_for(type)
      BG_COLOR_CLASSES[type.to_sym] || 'bg-info'
    end

    def icon_for(type)
      ICONS[type.to_sym] || 'info'
    end

    def title_for(type)
      type.to_s.humanize
    end
  end
end
