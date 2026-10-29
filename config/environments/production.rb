require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Prepare the ingress controller used to receive mail
  # config.action_mailbox.ingress = :relay

  # Settings specified here will take precedence over those in config/application.rb.
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Store uploaded files locally or in S3-compatible object storage.
  # Docker Compose can set ACTIVE_STORAGE_SERVICE=local.
  # Production deployment defaults to Hetzner.
  config.active_storage.service =
    ENV.fetch("ACTIVE_STORAGE_SERVICE", "hetzner").to_sym

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  # config.assume_ssl = true

  # Force HTTPS when the Rails master key is available.
  config.force_ssl = !ENV["RAILS_MASTER_KEY"].nil?

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # Send email through Gmail SMTP.
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_APP_PASSWORD"],
    authentication: :plain,
    enable_starttls_auto: true,
    open_timeout: 10,
    read_timeout: 10
  }

  config.action_mailer.default_options = {
    from: ENV["GMAIL_USERNAME"]
  }

  config.action_mailer.default_url_options = { host: "example.com" }

  # config.action_mailer.smtp_settings = {
  #   user_name: Rails.application.credentials.dig(:smtp, :user_name),
  #   password: Rails.application.credentials.dig(:smtp, :password),
  #   address: "smtp.example.com",
  #   port: 587,
  #   authentication: :plain
  # }

  config.i18n.fallbacks = true
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # config.hosts = [
  #   "example.com",
  #   /.*\.example\.com/
  # ]
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
