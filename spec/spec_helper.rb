RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand config.seed

  # https://www.relishapp.com/rspec/rspec-core/docs/configuration/excluding-lines-from-the-backtrace
  config.backtrace_exclusion_patterns = [ /gems/ ]

end
