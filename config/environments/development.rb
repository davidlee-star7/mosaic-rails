Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  #dinesh100ni
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

 


 


  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true



  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  #Paperclip.options[:command_path] = "/usr/local/bin/"

  config.host_ip = 'localhost'

  config.action_controller.default_url_options = {:host => 'http://' + config.host_ip + ':3000'}
  
# config.max_login_attempts = 10
# config.allowed_otp_drift_seconds = 180
# config.otp_length = 6
# {:host => 'http://52.27.151.238' }
  # config.action_mailer.default_url_options = {:host => 'http://52.27.151.238', :protocol => 'http'} #I've also tried it without ":protocol => 'http'"
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.perform_deliveries = true

  # config.action_mailer.smtp_settings = {
  #   :address   => "smtp.mandrillapp.com",
  #   :port      => 587,
  #   :user_name => "jordan",
  #   :password  => "5agSp1UnNN7bTR72qk63JA"
  # }

  config.action_mailer.default_url_options = { :host => 'localhost' }
  config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025 }
  config.paperclip_defaults = {
    :storage => :s3,
    :bucket => 'mosaiccms-dev'
  }

end




