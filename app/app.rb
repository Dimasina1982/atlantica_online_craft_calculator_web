# -*- encoding : utf-8 -*-
class CraftCalculator < Padrino::Application
  register Padrino::Rendering
  register Padrino::Helpers

  register Padrino::Mailer
  set :delivery_method, :smtp => {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'gmail.com',
    :user_name            => ENV['EMAIL_ADDRESS'],
    :password             => ENV['EMAIL_PASSWORD'],
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }

  register Padrino::Contrib::ExceptionNotifier
  set :exceptions_from, ENV['EMAIL_ADDRESS']
  set :exceptions_to, 'jana4u@seznam.cz'
  set :exceptions_subject, '[CraftCalculator Error]'
  set :exceptions_page, :errors # => views/errors.haml/erb
  # Uncomment this for test in development
  # disable :raise_errors
  # disable :show_exceptions

  register Sinatra::AssetPack

  Less.paths <<  "#{root}/assets/stylesheets"

  assets {
    serve '/js', from: 'assets/javascripts'
    serve '/css', from: 'assets/stylesheets'
    serve '/images', from: '../public/images'

    js :app, '/js/app.js', [
      '/js/jquery.js',
      '/js/jquery-ujs.js',
      '/js/application.js',
    ]

    css :app, '/css/app.css', [
      '/css/application.css',
    ]

    js_compression :jsmin
    css_compression :simple

    prebuild true
  }

  use Rack::Session::Cookie,
    :key => 'craft_calculator',
    :expire_after => 31_557_600,
    :secret => '84f54694bb020d61e07e175832ac82962cf1e618439862acbcfdf9a072a9fbbd'

  ##
  # Caching support
  #
  # register Padrino::Cache
  # enable :caching
  #
  # You can customize caching store engines:
  #
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
  #   set :cache, Padrino::Cache::Store::Memory.new(50)
  #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
  #

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #
end
