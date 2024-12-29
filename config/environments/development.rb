# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  configure_basic_settings
  configure_caching
  configure_active_storage
  configure_mailer
  configure_logs
  configure_assets
end

private

def configure_basic_settings
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
end

def configure_caching
  if caching_enabled?
    enable_caching
  else
    disable_caching
  end
end

private

def caching_enabled?
  Rails.root.join('tmp/caching-dev.txt').exist?
end

def enable_caching
  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = true
  config.cache_store = :memory_store
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}"
  }
end

def disable_caching
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
end

def configure_active_storage
  config.active_storage.service = :local
end

def configure_mailer
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end

def configure_logs
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
end

def configure_assets
  config.assets.debug = true
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
