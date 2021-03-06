ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '../app/', 'app.rb')

require './app/models/link'
require 'capybara'
require 'capybara/rspec'
require 'database_cleaner'
require 'rspec'
require 'features/web_helpers'

Capybara.app = BookmarkManager

RSpec.configure do |config|

  DataMapper.setup(:default, 'postgres://localhost/bookmark_manager_test')
  DataMapper.finalize
  DataMapper.auto_upgrade!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test
    if !driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
