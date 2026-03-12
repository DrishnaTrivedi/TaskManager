require "active_support/core_ext/integer/time"
Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
  config.action_mailer.delivery_method = :letter_opener_web
  config.action_mailer.perform_deliveries = true
end
