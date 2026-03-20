require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)
module TaskManager
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.load_defaults 8.0
    config.autoload_lib(ignore: %w[assets tasks])
    config.action_mailer.preview_paths << "#{Rails.root}/spec/mailers/previews"
  end
end
