require "active_support/core_ext/integer/time"
Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: Rails.application.credentials.gmail[:username],
    password: Rails.application.credentials.gmail[:password],
    authentication: 'plain',
    enable_starttls_auto: true
  }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

end
