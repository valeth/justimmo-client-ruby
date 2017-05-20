[![build status](https://gitlab.com/valeth/justimmo-ruby/badges/master/build.svg)](https://gitlab.com/valeth/justimmo-ruby/pipelines)
[![coverage report](https://gitlab.com/valeth/justimmo-ruby/badges/master/coverage.svg)](https://valeth.gitlab.io/justimmo-ruby)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7cfe6c9965214c439470cc0a480e0e49)](https://www.codacy.com/app/valeth/justimmo-ruby?utm_source=gitlab.com&amp;utm_medium=referral&amp;utm_content=valeth/justimmo-ruby&amp;utm_campaign=Badge_Grade)

# justimmo

Ruby wrapper for the [Justimmo](http://www.justimmo.at) [REST API](http://api-docs.justimmo.at/api/index.html).

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

Justimmo::Realty.list(filter: { zip_code: 6020 }, limit: 5)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and merge requests are welcome on
[GitLab](https://github.com/valeth/justimmo-ruby).


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Check the [LICENSE](LICENSE) file for more information.
