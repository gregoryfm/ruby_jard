# frozen_string_literal: true

module RubyJard
  module Decorators
    ##
    # Decorate Array data structure, supports singleline and multiline form.
    class ArrayDecorator
      def initialize(generic_decorator)
        @generic_decorator = generic_decorator
        @attributes_decorator = RubyJard::Decorators::AttributesDecorator.new(generic_decorator)
      end

      def match?(variable)
        RubyJard::Reflection.call_is_a?(variable, Array)
      end

      def decorate_singleline(variable, line_limit:, depth: 0)
        spans = []
        spans << RubyJard::Span.new(content: '[', styles: :text_primary)
        spans += @attributes_decorator.inline_values(
          variable.each_with_index, total: variable.length, line_limit: line_limit - 2, depth: depth + 1
        )
        spans << RubyJard::Span.new(content: ']', styles: :text_primary)

        spans
      end

      def decorate_multiline(variable, first_line_limit:, lines:, line_limit:, depth: 0)
        if variable.length > lines * 2
          return do_decorate_multiline(variable, lines: lines, line_limit: line_limit, depth: depth)
        end

        singleline = decorate_singleline(variable, line_limit: first_line_limit, depth: depth)
        if (singleline.map(&:content_length).sum < line_limit && same_type?(variable, lines)) || variable.length <= 1
          [singleline]
        else
          do_decorate_multiline(variable, lines: lines, line_limit: line_limit, depth: depth)
        end
      end

      private

      def same_type?(variable, sample)
        variable.first(sample).map { |item| RubyJard::Reflection.call_class(item) }.uniq.length <= 1
      end

      def do_decorate_multiline(variable, lines:, line_limit:, depth: 0)
        spans = [[RubyJard::Span.new(content: '[', styles: :text_primary)]]

        item_count = 0
        variable.each_with_index do |value, index|
          spans << @attributes_decorator.value(value, line_limit: line_limit, depth: depth + 1)

          item_count += 1
          break if index >= lines - 2
        end

        spans << last_line(variable.length, item_count)
      end

      def last_line(total, item_count)
        if total > item_count
          [
            RubyJard::Span.new(
              content: "▸ #{total - item_count} more...",
              margin_left: 2, styles: :text_dim
            ),
            RubyJard::Span.new(
              content: ']',
              styles: :text_primary
            )
          ]
        else
          [RubyJard::Span.new(content: ']', styles: :text_primary)]
        end
      end
    end
  end
end
