# frozen_string_literal: true

module Utilities
  module LocaleHelper
    def locale_name(locale)
      I18n::LOCALE_NAMES[locale]
    end
  end
end
