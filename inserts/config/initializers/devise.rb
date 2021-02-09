config.lock_strategy = :failed_attempts
config.unlock_keys = [:email]
config.unlock_strategy = :email
config.maximum_attempts = 10
config.last_attempt_warning = true
config.omniauth :facebook,
                Rails.application.credentials.dig(:omniauth, :facebook_app_id),
                Rails.application.credentials.dig(:omniauth, :facebook_app_secret)
config.omniauth :google_oauth2,
                Rails.application.credentials.dig(:omniauth, :google_client_id),
                Rails.application.credentials.dig(:omniauth, :google_client_secret),
                name: :google
