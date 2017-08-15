# frozen_string_literal: true

source "https://rubygems.org"

group :test do
  # Test coverage reporting
  gem "simplecov", require: false
end

group :test, :development do
  gem "rspec",   "~> 3.0"
  gem "rubocop", "~> 0.48"
  gem "dotenv"
end

group :development do
  gem "yard"
  gem "pry"
end

gemspec
