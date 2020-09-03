# frozen_string_literal: true

module RubyJard
  module Commands
    # Command used to explore stacktrace.
    class FrameCommand < Pry::ClassCommand
      include RubyJard::Commands::ValidationHelpers

      group 'RubyJard'
      description 'Explore to any frame of current stacktrace.'

      match 'frame'

      banner <<-BANNER
      Usage: frame [FRAME_ID]

      Explore to any frame of current stacktrace.

      Examples:
        frame 4 # Jump to frame 4 in the backtrace
      BANNER

      def initialize(context = {})
        super(context)
        @current_backtrace = (context[:session] || RubyJard::Session).current_backtrace
      end

      def process
        frame = validate_present!(args.first)
        frame = validate_non_negative_integer!(frame)
        frame = validate_range!(frame, 0, @current_backtrace.map(&:virtual_pos).compact.max)
        RubyJard::ControlFlow.dispatch(:frame, frame: frame)
      end
    end
  end
end

Pry::Commands.add_command(RubyJard::Commands::FrameCommand)
