require "spec_helper"

# We need to extend the module so that we can access the request methods
module JustimmoClient::V1::JustimmoRequest
  extend self
end

RSpec.describe JustimmoClient::V1::JustimmoRequest do
  let(:base_url) { "#{JustimmoClient::Config.url}/null" }

  before do
    stub_request(:get, "#{base_url}/noauth")
      .to_return(status: 401)

    stub_request(:get, base_url)
      .to_return(status: 400)

    stub_request(:get, base_url)
      .to_return(status: 404)

    stub_request(:get, base_url)
      .to_return(status: 500)

    stub_request(:get, base_url)
      .to_return(status: 500)
  end

  it "raises AuthenticationFailed on 401 error" do
    expect { described_class.get("null/noauth") }
      .to raise_exception(JustimmoClient::AuthenticationFailed)
  end

  it "raises RetrievalFailed on 400 error" do
    expect { described_class.get("null") }
      .to raise_exception(JustimmoClient::RetrievalFailed)
  end

  it "raises RetrievalFailed on 404 error" do
    expect { described_class.get("null") }
      .to raise_exception(JustimmoClient::RetrievalFailed)
  end

  it "raises RetrievalFailed on 500 error" do
    expect { described_class.get("null") }
      .to raise_exception(JustimmoClient::RetrievalFailed)
  end

  it "retries on RetrievalFailed" do
    Retriable.configure do |c|
      c.tries = 3
      c.base_interval = 0.1
    end

    expect { described_class.get("null") }
      .to raise_exception(JustimmoClient::RetrievalFailed)

    expect(a_request(:get, base_url))
      .to have_been_made.times(3)
  end
end
