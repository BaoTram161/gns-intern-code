source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.4"

# The modern asset pipeline for Rails
gem "propshaft"

# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"

# Use the Puma web server
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire's SPA-like page accelerator
gem "turbo-rails"

# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Use Tailwind CSS
gem "tailwindcss-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma
gem "thruster", require: false

# Use Active Storage variants
gem "image_processing", "~> 1.2"

# Use S3-compatible object storage (Hetzner Object Storage)
gem "aws-sdk-s3", require: false

group :development, :test do
  # See Rails debugging guide
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Audits gems for known security vulnerabilities
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities
  gem "brakeman", require: false

  # Omakase Ruby styling
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages
  gem "web-console"
end

group :test do
  # Use system testing
  gem "capybara"
  gem "selenium-webdriver"
end