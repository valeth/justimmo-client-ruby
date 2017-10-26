require "bundler/setup"
require "simplecov"
require "webmock/rspec"
require "factory_girl"
require "retriable"

require "justimmo_client"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions

    # Mock configuration
    JustimmoClient.configure do |c|
      c.username = "user"
      c.password = "pass"
      c.base_url = "testing"
    end

    # Disable the logger
    JustimmoClient::Logging.logger = Logger.new(nil)

    Retriable.configure do |c|
      c.tries = 1
      c.base_interval = 1.0
      c.multiplier = 1.0
      c.rand_factor = 0.0
    end
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixture(path)
  File.read(File.join(__dir__, "fixtures", path))
end
