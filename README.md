[![build status](https://gitlab.com/exacting/justimmo-client-ruby/badges/master/build.svg)](https://gitlab.com/exacting/justimmo-client-ruby/pipelines)
[![coverage report](https://gitlab.com/exacting/justimmo-client-ruby/badges/master/coverage.svg)](https://valeth.gitlab.io/justimmo-client-ruby)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7cfe6c9965214c439470cc0a480e0e49)](https://www.codacy.com/app/exacting/justimmo-client-ruby?utm_source=gitlab.com&amp;utm_medium=referral&amp;utm_content=exacting/justimmo-client-ruby&amp;utm_campaign=Badge_Grade)
[![Inline docs](http://inch-ci.org/github/exacting/justimmo-client-ruby.svg?branch=master)](http://inch-ci.org/github/exacting/justimmo-client-ruby)


# Justimmo Client

Ruby client for the [Justimmo](http://www.justimmo.at) [REST API](http://api-docs.justimmo.at/api/index.html).

## Dependencies

* Ruby 2.3+

## Installation

Add this line to your application's Gemfile:

```ruby
gem "justimmo_client"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install justimmo_client


## Usage Example (Rails)

> config/initializers/justimmo.rb
```ruby
JustimmoClient.configure do |config|
  config.username = "your-username"
  config.password = "your_password"
  config.cache    = ActiveSupport::Cache.lookup_store(:memory_store)
end
```

---

> app/controllers/realty_controller.rb
```ruby
class RealtyController < ApplicationController
  def index
    @realties = JustimmoClient::Realty.list(zip_code: 6020, limit: 5)
  end
end
```

For other examples see [examples](examples/).

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, put your user credentials into a `.env` file and run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and merge requests are welcome on
[GitLab](https://gitlab.com/exacting/justimmo-client-ruby).


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Check the [LICENSE](LICENSE) file for more information.
