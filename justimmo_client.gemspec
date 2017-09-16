# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "justimmo_client/version"

Gem::Specification.new do |spec|
  spec.name          = "justimmo_client"
  spec.version       = JustimmoClient::VERSION
  spec.author        = "Patrick Auernig"
  spec.email         = "patrick.auernig@mykolab.com"
  spec.license       = "MIT"
  spec.summary       = "API client for Justimmo"
  spec.homepage      = "https://gitlab.com/exacting/justimmo-client-ruby"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake",    "~> 10.0"

  # requests
  spec.add_dependency "rest-client", "~> 2"
  spec.add_dependency "retriable",   "~> 2.0"

  # parsing
  spec.add_dependency "nokogiri", "~> 1.7"
  spec.add_dependency "multi_json"
  spec.add_dependency "representable", "~> 3.0"

  # models
  spec.add_dependency "virtus"
  spec.add_dependency "activesupport", "~> 5.1"
  spec.add_dependency "iso_country_codes"
  spec.add_dependency "monetize"
end