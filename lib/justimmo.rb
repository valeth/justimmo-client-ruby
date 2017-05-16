require 'justimmo/version'
require 'justimmo/errors'
require 'justimmo/config'
require 'justimmo/logger'
require 'justimmo/parser'

# require 'justimmo/realty'

module Justimmo
  def self.configure(&block)
    Justimmo::Config.configure(&block)
    Justimmo::Logger.configure(Justimmo::Config)
  end
end
