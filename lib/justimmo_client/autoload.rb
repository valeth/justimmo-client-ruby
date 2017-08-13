# frozen_string_literal: true

require "justimmo_client/version"
require "justimmo_client/errors"
require "justimmo_client/misc"

module JustimmoClient
  autoload :Config,   "justimmo_client/core/config"
  autoload :Logging,  "justimmo_client/core/logging"
  autoload :Utils,    "justimmo_client/core/utils"
  autoload :Caching,  "justimmo_client/core/caching"
  autoload :Realty,   "justimmo_client/realty"
  autoload :Employee, "justimmo_client/employee"
end
