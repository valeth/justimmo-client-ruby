require 'logger'

module Justimmo
  LOGGER = Logger.new(STDOUT)
  LOGGER.level = Logger::DEBUG if ENV['DEBUG']
  LOGGER.formatter = proc do |severity, datetime, progname, msg|
    "#{severity}  [#{datetime}]  #{msg}\n"
  end
end
