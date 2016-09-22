# Thor::Hollaback

[![Build Status](https://travis-ci.com/localytics/thor-hollaback.svg?token=kQUiABmGkzyHdJdMnCnv&branch=master)](https://travis-ci.com/localytics/thor-hollaback)
[![Coverage Status](https://coveralls.io/repos/github/localytics/thor-hollaback/badge.svg?branch=master&t=7r5orD)](https://coveralls.io/github/localytics/thor-hollaback?branch=master)
[![Artifactory Version](http://artifactory-badge.gw.localytics.com/gem/thor-hollaback)](https://localytics.artifactoryonline.com/localytics/webapp/#/home)

Adds callbacks to thor commands.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thor-hollaback'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thor-hollaback

## Usage

Uses the [`hollaback`](https://github.com/localytics/hollaback) gem to add callbacks to [`thor`](https://github.com/erikhuda/thor) commands. Example below:

```ruby
class CLI < Thor
  desc 'test', 'Test command'
  before :say_hello
  after :say_goodbye
  after { puts '- Thor::Hollaback' }
  around :say
  def test
    puts 'How are you?'
  end

  no_commands do
    def say_hello
      puts 'Hello!'
    end

    def say_goodbye
      puts 'Goodbye!'
    end

    def say
      puts 'Speaking...'
      yield
      puts '...done.'
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/localytics/thor-hollaback.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
