require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

require 'rubygems'
#require 'tableau_ruby'


#Tableau.configure do |config|
    # Required
 #   config.host = 'https://mosaic-tableau.com'
 #   config.admin_name = 'phil@mosaicsustainability.com'
 #   config.admin_password = 'Bison47!'
    # Optional
#    config.user_name = 'phil@mosaicsustainability.com'
    #config.site_name = 'defaults-to-Default'
#end





# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mosic2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # if Rails.env.development? 
    # config.action_controller.default_url_options = {:host => "http://localhost:3000"}
    # elsif Rails.env.production?
    # config.action_controller.default_url_options = {:host => "http://50.112.88.230"}
    # else
    # config.action_controller.default_url_options = {:host => "http://localhost:3000"}
    # end


config.before_configuration do
  env_file = File.join(Rails.root, 'config', 'local_env.yml')
  YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value
  end if File.exists?(env_file)
end



  end
end
