# frozen_string_literal: true

require "active_support/inflector/inflections"
require "active_support/i18n"
require "retriable"
require "justimmo_client/core/config"
require "justimmo_client/core/logging"

module JustimmoClient
  extend JustimmoClient::Logging

  ActiveSupport::Inflector.inflections do |inflect|
    inflect.acronym "XML"
    inflect.acronym "JSON"
  end

  I18n.load_path += Dir[File.expand_path("../../locales/*.yml", __dir__)]
  I18n.default_locale = :en

  Retriable.configure do |c|
    c.base_interval = 2.0
    c.tries = JustimmoClient::Config.request_retries
    c.on_retry = proc do |exception, try, elapsed_time, next_interval|
      log.error("#{exception.class}: #{exception}")
      log.error("Try #{try} in #{elapsed_time} seconds, retrying in #{next_interval} seconds.")
    end
    c.on = JustimmoClient::RetrievalFailed
  end
end
