# frozen_string_literal: true

require "test_helper"

class Thor
  class HollabackTest < Minitest::Test
    class CallbackCLI < Thor
      class_before :say_hello
      class_after :say_goodbye
      class_around :say

      desc "alpha", "Alpha command"
      after { puts "- Thor::Hollaback" }
      def alpha
        puts "How are you?"
      end

      desc "beta", "Beta command"
      before :say_hello
      around :say
      def beta
        puts "Repeating myself"
      end

      no_commands do
        def say_hello
          puts "Hello!"
        end

        def say_goodbye
          puts "Goodbye!"
        end

        def say
          puts "Speaking..."
          yield
          puts "...done."
        end
      end
    end

    class EmptyCLI < Thor
      desc "gamma", "Gamma command"
      def gamma
        print "Hello world"
      end
    end

    class ParentCLI < Thor
      class ChildCLI < Thor
        desc "child", "Child command"
        before { puts "Hello from child" }
        after { puts "Goodbye from child" }
        def child
          puts "Child"
        end
      end

      desc "parent", "Parent command"
      before { puts "Hello from parent" }
      after { puts "Goodbye from parent" }
      subcommand "parent", ChildCLI
    end

    def test_alpha
      stdout, = capture_io { CallbackCLI.start(["alpha"]) }
      expected = [
        "Speaking...",
        "Hello!",
        "How are you?",
        "- Thor::Hollaback",
        "Goodbye!",
        "...done."
      ]
      assert_equal expected, stdout.split("\n")
    end

    def test_beta
      stdout, = capture_io { CallbackCLI.start(["beta"]) }
      expected = [
        "Speaking...",
        "Hello!",
        "Speaking...",
        "Hello!",
        "Repeating myself",
        "...done.",
        "Goodbye!",
        "...done."
      ]
      assert_equal expected, stdout.split("\n")
    end

    def test_empty
      stdout, = capture_io { EmptyCLI.start(["gamma"]) }
      assert_equal "Hello world", stdout
    end

    def test_bad_command
      stdout, =
        capture_io do
          Class.new(Thor) do
            def command
            end
          end
        end
      assert_operator stdout, :start_with?, "[WARNING]"
    end

    def test_subcommand
      stdout, = capture_io { ParentCLI.start(%w[parent child]) }
      expected = [
        "Hello from parent",
        "Hello from child",
        "Child",
        "Goodbye from child",
        "Goodbye from parent"
      ]

      assert_equal expected, stdout.split("\n")
    end

    def test_version
      refute_nil Thor::Hollaback::VERSION
    end
  end
end
