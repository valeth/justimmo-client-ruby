#!/usr/bin/env ruby

require "dotenv"
require "pp"
require "active_support/cache"
require "justimmo_client"

Dotenv.load

JustimmoClient.configure do |config|
  config.username = ENV["JUSTIMMO_USERNAME"]
  config.password = ENV["JUSTIMMO_PASSWORD"]
  config.cache    = ActiveSupport::Cache.lookup_store(:memory_store)
end

pp JustimmoClient::Realty.list(zip_code: 6800, limit: 5)
