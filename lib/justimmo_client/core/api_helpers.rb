# frozen_string_literal: true

module JustimmoClient
  module API
    def versioned_api(*name)
      (["JustimmoClient::V#{JustimmoClient::Config.api_ver}"] + name).join("::").constantize
    end

    def api(name)
      "JustimmoClient::#{name.to_s.classify}".constantize
    end

    def representer(name, type = :xml)
      versioned_api(type.to_s.classify, "#{name.to_s.classify}Representer")
    end

    def model(name)
      versioned_api(name.to_s.classify)
    end

    def request(name)
      versioned_api("#{name.to_s.classify}Request")
    end

    def interface(name)
      versioned_api("#{name.to_s.classify}Interface")
    end
  end
end
