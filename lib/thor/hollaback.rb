require 'thor'
require 'hollaback'
require 'thor/hollaback/version'

class Thor
  module Hollaback
    module ClassExt
      # Methods for overall callbacks
      def all_callback_chain
        @all_callback_chain ||= ::Hollaback::Chain.new
      end

      def after_all(execute = nil, &block)
        all_callback_chain.after(execute, &block)
      end

      def before_all(execute = nil, &block)
        all_callback_chain.before(execute, &block)
      end

      def around_all(execute = nil, &block)
        all_callback_chain.around(execute, &block)
      end

      # Methods for individual command callbacks
      def callback_chain
        @callback_chain ||= ::Hollaback::Chain.new
      end

      def before(execute = nil, &block)
        callback_chain.before(execute, &block)
      end

      def after(execute = nil, &block)
        callback_chain.after(execute, &block)
      end

      def around(execute = nil, &block)
        callback_chain.around(execute, &block)
      end

      def create_command(meth)
        super
        commands[meth].callback_chain = callback_chain if commands[meth]
        @callback_chain = nil
      end
    end

    module CommandExt
      def self.prepended(base)
        base.send(:attr_accessor, :callback_chain)
      end

      def run(cli, *args)
        if cli.class.all_callback_chain.empty? && callback_chain.empty?
          super
        else
          combined = callback_chain + cli.class.all_callback_chain
          combined.compile { super }.call(cli)
        end
      end
    end
  end
end

Thor.singleton_class.prepend(Thor::Hollaback::ClassExt)
Thor::Command.prepend(Thor::Hollaback::CommandExt)
