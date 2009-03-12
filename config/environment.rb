# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.1' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use (only works if using vendor/rails).
  # To use Rails without a database, you must remove the Active Record framework
  config.frameworks -= [ :active_resource ]

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  config.log_level = :info

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_tracknowledge_session',
    :secret      => '55538da3290bfaf872608afd23e6e95c5b55539c169ad0ed8028e3bb0f2027b63d44f6940a7caefad8f2909171b8022f32da3ebe8bdc1ac1c37fe0d1158b7b62'
  }

#	config.gem 'mime-types', :lib => 'mime/types'
	config.gem 'mime-types', :lib => 'mime/types'
	config.gem 'tmm1-youtube-g', :lib => 'youtube_g', :source => 'http://gems.github.com'#, :version => '0.4.9.9'
	config.gem 'commonthread-flickr_fu', :lib => 'flickr_fu', :source => 'http://gems.github.com'#, :version => '0.1.6'
	config.gem 'ruby-openid', :lib => 'openid'#, :version => '2.1.2'
  config.gem 'fiveruns-dash-rails', :lib => 'fiveruns_dash_rails', :source => 'http://gems.github.com'
  config.gem 'newrelic_rpm'
	config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
	config.gem 'andre-geokit', :lib => 'geokit', :source => 'http://gems.github.com'
  config.gem 'mperham-deadlock_retry', :lib => 'deadlock_retry', :source => 'http://gems.github.com'
  config.gem 'grit'

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  config.active_record.default_timezone = :utc
  config.threadsafe! if RAILS_ENV == 'production'
end

#RAILS_DEFAULT_LOGGER.flush
#RAILS_DEFAULT_LOGGER.auto_flushing = true