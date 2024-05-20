module LocalesHelper
  def available_locales
    available_locales = []

    I18n.available_locales.each do |available_locale|
      available_locales << {
        title: I18n::LOCALE_NAMES[available_locale].capitalize,
        path: url_for(locale: available_locale)
      }
    end

    available_locales
  end
end
