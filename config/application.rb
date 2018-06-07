require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

RSpotify.authenticate("3e927350c48848e2af1c93c9bde9376f", "8bf82ef52e944b2fa46bdc6c73812422")

module V3spotify
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.web_console.whiny_requests = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
