# frozen_string_literal: true

module Utilities
  module I18nHelper
    def available_locales
      available_locales = []

      I18n.available_locales.each do |available_local|
        available_locales << {
          title: locale_name(available_local).capitalize,
          path: url_for(locale: available_local)
        }
      end

      available_locales
    end
  end
end
