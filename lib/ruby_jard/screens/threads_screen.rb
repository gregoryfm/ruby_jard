# frozen_string_literal: true

module RubyJard
  class Screens
    ##
    # Display all current alive threads, excluding internal threads
    class ThreadsScreen < RubyJard::Screen
      def title
        ['Threads', "#{@session.threads.length} threads"]
      end

      def build
        contexts = @session.threads.select { |c| c.thread.alive? }
        contexts = sort_contexts(contexts)
        @rows = contexts.map do |context|
          RubyJard::Row.new(
            line_limit: 2,
            columns: [
              RubyJard::Column.new(
                spans: [
                  span_mark(context),
                  span_thread_id(context)
                ]
              ),
              RubyJard::Column.new(
                spans: [
                  span_thread_status(context)
                ]
              ),
              RubyJard::Column.new(
                spans: [
                  span_thread_name(context),
                  span_thread_location(context)
                ]
              )
            ]
          )
        end
        @selected = contexts.index { |c| current_thread?(c) }
      end

      private

      def span_mark(context)
        style = thread_status_style(context.thread)
        RubyJard::Span.new(
          margin_right: 1,
          content: style == :thread_status_run ? '►' : '•',
          styles: style
        )
      end

      def span_thread_id(context)
        RubyJard::Span.new(
          content: "Thread #{context.thread.object_id}",
          styles: :thread_id
        )
      end

      def span_thread_status(context)
        RubyJard::Span.new(
          content: "(#{context.thread.status})",
          styles: thread_status_style(context.thread)
        )
      end

      def span_thread_name(context)
        RubyJard::Span.new(
          margin_right: 1,
          content: context.thread.name.nil? ? 'untitled' : context.thread.name,
          styles: :thread_name
        )
      end

      def span_thread_location(context)
        return unknown_thread_location if
          context.thread.backtrace_locations.nil? ||
          @session.current_frame.frame_location.nil?

        last_backtrace =
          if current_thread?(context)
            @session.current_frame.frame_location
          else
            context.thread.backtrace_locations[1]
          end

        return unknown_thread_location if last_backtrace.nil?

        path_decorator = RubyJard::Decorators::PathDecorator.new(last_backtrace.path, last_backtrace.lineno)
        if path_decorator.source_tree? || path_decorator.unknown?
          RubyJard::Span.new(
            content: "at #{path_decorator.path_label}:#{path_decorator.lineno}",
            styles: :thread_location
          )
        else
          RubyJard::Span.new(
            content: "in #{path_decorator.path_label}",
            styles: :thread_location
          )
        end
      end

      def unknown_thread_location
        RubyJard::Span.new(
          content: 'at ???',
          styles: :thread_location
        )
      end

      def sort_contexts(contexts)
        # Sort: current context first
        # Sort: not debug context first
        # Sort: not suspended context first
        # Sort: sort by thread num
        contexts.sort do |a, b|
          [
            bool_to_int(current_thread?(a)),
            bool_to_int(b.thread.name.nil?),
            a.thread.object_id
          ] <=> [
            bool_to_int(current_thread?(b)),
            bool_to_int(a.thread.name.nil?),
            b.thread.object_id
          ]
        end
      end

      def bool_to_int(bool)
        bool == true ? -1 : 1
      end

      def current_thread?(context)
        context.thread == Thread.current
      end

      def create_path_decorator(path, lineno)
      end

      def thread_status_style(thread)
        case thread.status
        when 'run'
          :thread_status_run
        when 'sleep'
          :thread_status_sleep
        else
          :thread_status_other
        end
      end
    end
  end
end

RubyJard::Screens.add_screen('threads', RubyJard::Screens::ThreadsScreen)
