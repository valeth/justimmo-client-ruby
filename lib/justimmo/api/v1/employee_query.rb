# frozen_string_literal: true

require "json"

module Justimmo::API
  # Get employee information from the API.
  module EmployeeQuery
    extend Justimmo::API::Query

    module_function

    def list
      cache_key = Digest::SHA256.hexdigest("employee/list")
      with_cache(cache_key) { request("team/list") }
    end

    def detail(id)
      cache_key = Digest::SHA256.hexdigest("employee/detail:#{id}")
      with_cache(cache_key) { request("team/detail", id: id) }
    end

    def ids
      cache_key = Digest::SHA256.hexdigest("employee/ids")
      response = with_cache(cache_key) { request("team/ids") }
      JSON.parse(response).map(&:to_i)
    rescue JSON::ParserError => e
      log.error(e)
      []
    end
  end
end
