# frozen_string_literal: true

Rails.application.config.i18n.default_locale = CsIss::Config.locale

if Rails.env.production?
  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  Rails.application.config.i18n.fallbacks = true
end
