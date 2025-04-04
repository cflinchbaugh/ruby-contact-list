require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Reload code without restarting the server.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable caching
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{2.days.to_i}" }
    config.cache_store = :memory_store
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files locally
  config.active_storage.service = :local

  # Mailer Configuration
  config.action_mailer.raise_delivery_errors = true  # Enable error reporting
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    authentication: "plain",
    enable_starttls_auto: true
  }

  # Log a warning if Gmail credentials are missing
  if ENV["GMAIL_USERNAME"].blank? || ENV["GMAIL_PASSWORD"].blank?
    Rails.logger.warn("WARNING: Gmail credentials are missing! Emails may not be sent.")
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight queries and their origins in logs.
  config.active_record.verbose_query_logs = true
  config.active_record.query_log_tags_enabled = true  # For Rails 7+

  # Highlight background jobs in logs.
  config.active_job.verbose_enqueue_logs = true

  # Display file names in rendered views.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Raise errors for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Raise an error for missing before_action filters in controllers.
  config.action_controller.raise_on_missing_callback_actions = true
end
