# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require File.expand_path('../config/boot', __dir__)

Dir['./spec/shared/**/*.rb'].each { |f| require f }
Dir['./spec/*/factories/**/*.rb'].each { |f| require f }

module RSpecMixin
  include Rack::Test::Methods
  def app
    Rack::Builder.new do
      use Rack::PostBodyContentTypeParser
      run Rack::URLMap.new('/' => App, '/api/v1' => Api)
    end
  end
end

db_cleaner = DatabaseCleaner[:sequel, connection: DB]

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) { FactoryBot.find_definitions }
end
