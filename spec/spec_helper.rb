require "bundler/setup"
require "simplecov"

require "justimmo_client"

# Disable the logger for tests
JustimmoClient::Logging.logger = Logger.new(nil)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def fixture(name, path)
  File.read(File.join(__dir__, "data", path, "#{name}.xml"))
end
