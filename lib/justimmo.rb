require 'justimmo/version'
require 'justimmo/errors'
require 'justimmo/config'
require 'justimmo/logger'

module Justimmo
  def self.configure(&block)
    Justimmo::Config.configure(&block)
  end
end
