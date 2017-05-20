#!/usr/bin/env ruby

require 'justimmo'
require 'dotenv'
require 'pp'

Dotenv.load

Justimmo.configure do |config|
  config.username = ENV['JUSTIMMO_USERNAME']
  config.password = ENV['JUSTIMMO_PASSWORD']
end

pp Justimmo::Realty.list(filter: { zip_code: 6800 }, limit: 5)
