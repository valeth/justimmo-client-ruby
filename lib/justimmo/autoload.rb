# frozen_string_literal: true

require "justimmo/version"
require "justimmo/errors"
require "justimmo/misc"

module Justimmo
  autoload :Config,   "justimmo/core/config"
  autoload :Logging,  "justimmo/core/logging"
  autoload :Utils,    "justimmo/core/utils"
  autoload :Caching,  "justimmo/core/caching"
  autoload :Realty,   "justimmo/realty"
  autoload :Employee, "justimmo/employee"
end
