# frozen_string_literal: true

require "justimmo_client/version"
require "justimmo_client/errors"

module JustimmoClient
  include JustimmoClient::Errors

  require "justimmo_client/misc"

  autoload :Config,   "justimmo_client/core/config"
  autoload :Logging,  "justimmo_client/core/logging"
  autoload :Utils,    "justimmo_client/core/utils"
  autoload :API,      "justimmo_client/core/api_helpers"
  autoload :Caching,  "justimmo_client/core/caching"
  autoload :OptionParser, "justimmo_client/option_parser"
end
