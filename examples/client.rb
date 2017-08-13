#!/usr/bin/env ruby

require "justimmo_client"
require "dotenv"
require "pp"

Dotenv.load

JustimmoClient.configure do |config|
  config.username = ENV["JUSTIMMO_USERNAME"]
  config.password = ENV["JUSTIMMO_PASSWORD"]
end

pp JustimmoClient::Realty.list(zip_code: 6800, limit: 5)
