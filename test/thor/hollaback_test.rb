require 'test_helper'

class Thor::HollabackTest < Minitest::Test
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

  def test_calls_callbacks
    stdout, = capture_io { CLI.start(['test']) }
    expected = ['Speaking...', 'Hello!', 'How are you?', 'Goodbye!', '- Thor::Hollaback', '...done.']
    assert_equal expected, stdout.split("\n")
  end

  def test_version
    refute_nil Thor::Hollaback::VERSION
  end
end
