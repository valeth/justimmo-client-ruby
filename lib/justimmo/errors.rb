# frozen_string_literal: true

module Justimmo
  JustimmoError = Class.new(StandardError)
  InitializationError = Class.new(JustimmoError)

  # Raised when configuration validation fails.
  ConfigurationError = Class.new(JustimmoError)

  # Raised when authentication with the API fails.
  class AuthenticationFailed < JustimmoError
    def initialize
      super("Authentication failed.")
    end
  end

  # Raised when retrieval from the API fails.
  class RetrievalFailed < JustimmoError
    def initialize(message)
      super("Failed to get data from the API: #{message}")
    end
  end

  # A mapping could not be found in the mappings hash.
  class MappingNotFound < JustimmoError
    def initialize(map)
      super("Could not find #{map} mapping.")
    end
  end

  # A key could not be found in the specified mapping.
  class KeyNotFound < JustimmoError
    def initialize(key, map)
      super("Key #{key} not found in #{map} mapping.")
    end
  end

  class NotImplemented < JustimmoError
    def initialize(meth)
      super("Method #{meth} not implemented!")
    end
  end

  # Raised when an unsupported API version is set.
  class UnsupportedAPIVersion < ConfigurationError
    def initialize(version)
      super("API Version #{version} not supported.")
    end
  end

  # Raised on missing required configuration options.
  class MissingConfiguration < ConfigurationError
    def initialize(missing)
      super("Required configuration missing: #{missing}.")
    end
  end
end
