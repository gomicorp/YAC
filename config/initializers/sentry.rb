# frozen_string_literal: true

if Rails.env.production?
  Raven.configure do |config|
    config.dsn              = Rails.application.credentials.dig(:sentry, :dsn)
    config.sanitize_fields  = Rails.application.config.filter_parameters.map(&:to_s)
  end
end
