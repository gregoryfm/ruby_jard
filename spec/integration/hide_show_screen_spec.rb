# frozen_string_literal: true

RSpec.describe 'Hide/show screens', integration: true do
  let(:work_dir) { File.join(RSPEC_ROOT, '/integration') }
  let(:initial_screen) do
    <<~SCREEN
      ┌ Source  -e:3 ─────────────────────────────────────────────────┬ Variables ─────────────────────────────────────────────────────┐
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      ├ Backtrace  1 frames ──────────────────────────────────────────┼ Threads  1 threads ────────────────────────────────────────────┤
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
      ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
      │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
      └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
      jard >>
    SCREEN
  end

  context 'when hiding/showing a screen on the top' do
    let(:screen_1) do
      <<~SCREEN
        ┌ Source  -e:3 ─────────────────────────────────────────────────┬ Threads  1 threads ────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├ Backtrace  1 frames ──────────────────────────────────────────┤????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    end

    let(:screen_2) do
      <<~SCREEN
        ┌ Backtrace  1 frames ──────────────────────────────────────────┬ Threads  1 threads ────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    end

    let(:screen_3) do
      <<~SCREEN
        ┌ Backtrace  1 frames ──────────────────────────────────────────┬ Variables ─────────────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????├ Threads  1 threads ────────────────────────────────────────────┤
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    end

    it 'strecthes the lower screens' do
      test = JardIntegrationTest.new(
        work_dir, "bundle exec ruby -e \"require 'ruby_jard'\njard\na = 1\"",
        width: 130, height: 30
      )
      test.start
      expect(test.screen_content).to match_repl(initial_screen)

      test.send_keys('jard hide variables', :Enter)
      expect(test.screen_content).to match_repl(screen_1)

      test.send_keys('jard hide source', :Enter)
      expect(test.screen_content).to match_repl(screen_2)

      test.send_keys('jard show variables', :Enter)
      expect(test.screen_content).to match_repl(screen_3)

      test.send_keys('jard show source', :Enter)
      expect(test.screen_content).to match_repl(initial_screen)
    ensure
      test.stop
    end
  end

  context 'when hiding/showing a screen on the bottom' do
    let(:screen_1) do
      <<~SCREEN
        ┌ Source  -e:3 ─────────────────────────────────────────────────┬ Variables ─────────────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├ Backtrace  1 frames ──────────────────────────────────────────┤????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    end

    let(:screen_2) do
      <<~SCREEN
        ┌ Source  -e:3 ─────────────────────────────────────────────────┬ Variables ─────────────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    end

    let(:screen_3) do
      <<~SCREEN
        ┌ Source  -e:3 ─────────────────────────────────────────────────┬ Variables ─────────────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????├ Threads  1 threads ────────────────────────────────────────────┤
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    end

    it 'strecthes the upper screens' do
      test = JardIntegrationTest.new(
        work_dir, "bundle exec ruby -e \"require 'ruby_jard'\njard\na = 1\"",
        width: 130, height: 30
      )
      test.start
      expect(test.screen_content).to match_repl(initial_screen)

      test.send_keys('jard hide threads', :Enter)
      expect(test.screen_content).to match_repl(screen_1)

      test.send_keys('jard hide backtrace', :Enter)
      expect(test.screen_content).to match_repl(screen_2)

      test.send_keys('jard show threads', :Enter)
      expect(test.screen_content).to match_repl(screen_3)

      test.send_keys('jard show backtrace', :Enter)
      expect(test.screen_content).to match_repl(initial_screen)
    ensure
      test.stop
    end
  end

  context 'when hiding/showing a screen not in the same column' do
    it 'strecthes the neighbor screens' do
      test = JardIntegrationTest.new(
        work_dir, "bundle exec ruby -e \"require 'ruby_jard'\njard\na = 1\"",
        width: 130, height: 30
      )

      test.start
      expect(test.screen_content).to match_repl(initial_screen)

      test.send_keys('jard hide threads', :Enter)
      test.send_keys('jard hide backtrace', :Enter)
      test.send_keys('jard hide source', :Enter)

      expect(test.screen_content).to match_repl(<<~SCREEN)
        ┌ Variables ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        ├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN

      test.send_keys('jard show source', :Enter)

      expect(test.screen_content).to match_repl(<<~SCREEN)
        ┌ Source  -e:3 ─────────────────────────────────────────────────┬ Variables ─────────────────────────────────────────────────────┐
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        │???????????????????????????????????????????????????????????????│????????????????????????????????????????????????????????????????│
        ├───────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────┤
        │????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????│
        └────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
        jard >>
      SCREEN
    ensure
      test.stop
    end
  end
end
