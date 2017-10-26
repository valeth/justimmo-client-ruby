# frozen_string_literal: true

source "https://rubygems.org"

group :test, :development do
  gem "rubocop", "0.51", require: false
  gem "dotenv"
end

group :test do
  gem "simplecov", require: false
  gem "factory_girl", "4.8.1"
  gem "rspec",        "~> 3.0"
  gem "webmock",      "~> 3.1.0"
end

group :development do
  gem "yard"
  gem "pry"
end

gemspec
