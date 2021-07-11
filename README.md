# Thor::Hollaback

[![Build Status](https://github.com/kddnewton/thor-hollaback/workflows/Main/badge.svg)](https://github.com/kddnewton/thor-hollaback/actions)
[![Gem Version](https://img.shields.io/gem/v/thor-hollaback.svg)](https://rubygems.org/gems/thor-hollaback)

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

Uses the [`hollaback`](https://github.com/kddnewton/hollaback) gem to add callbacks to [`thor`](https://github.com/erikhuda/thor) commands. You can set CLI-level callbacks with the macros `class_before`, `class_after`, and `class_around`. You can set command-level callbacks with `before`, `after`, and `around`. Example below.

```ruby
class CLI < Thor
  class_before :say_hello
  class_after :say_goodbye

  desc 'first_test', 'First test command'
  around :say
  def first_test
    puts 'How are you?'
  end

  desc 'second_test', 'Second test command'
  def second_test
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

When invoked, the above CLI results with:

```
irb(main):001:0> CLI.start(['first_test'])
Hello!
Speaking...
How are you?
...done.
Goodbye!
=> nil
```

and

```
irb(main):001:0> CLI.start(['second_test'])
Hello!
How are you?
Goodbye!
=> nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kddnewton/thor-hollaback.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
