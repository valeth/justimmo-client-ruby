[![build status](https://gitlab.com/valeth/justimmo-ruby/badges/master/build.svg)](https://gitlab.com/valeth/justimmo-ruby/commits/master)
[![coverage report](https://gitlab.com/valeth/justimmo-ruby/badges/master/coverage.svg)](https://gitlab.com/valeth/justimmo-ruby/commits/master)

# justimmo

Ruby wrapper for the [Justimmo](http://www.justimmo.at) REST API.

## Dependencies

* Ruby 2.3+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'justimmo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install justimmo

## Usage

```ruby
require 'justimmo'

Justimmo.configure do |config|
  config.username = 'your-username'
  config.password = 'your_password'
end

Justimmo::Realty.find({ zip_code: 6020 }, limit: 5)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Architecture
      ┌────────────┐
      │            │
    Query ─ Parser ┴ Resource
              │
            Mapper

The query interface retrieves raw XML data from the API, which will be parsed and mapped if necessary.

The resulting data will be converted into a Resource object.

## Contributing

Bug reports and merge requests are welcome on
[GitLab](https://github.com/valeth/justimmo-ruby).


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Check the [LICENSE](LICENSE) file for more information.
