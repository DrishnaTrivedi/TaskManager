require "active_support/core_ext/integer/time"
Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = false
  config.cache_store = :null_store
end
