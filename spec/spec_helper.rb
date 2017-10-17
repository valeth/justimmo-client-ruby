require "bundler/setup"
require "simplecov"

SimpleCov.start do
  add_filter "/bin/"
  add_filter "/cache/"
  add_filter "/examples/"
  add_filter "/spec/"
  add_group "V1/Models", "lib/justimmo_client/api/v1/models"
  add_group "V1/Representers", "lib/justimmo_client/api/v1/representers"
  add_group "V1/Requests", "lib/justimmo_client/api/v1/requests"
  add_group "V1/Interfaces", "lib/justimmo_client/api/v1/interfaces"
end

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
