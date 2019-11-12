require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter if ENV['COVERALLS_REPO_TOKEN']

SimpleCov.start do
  add_filter ['/spec/', '/lib/apexcharts/support', '/examples/']
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

require 'apexcharts/helper'

def id_fiber
  @id_fiber ||= Fiber.new do
    Fiber.yield "chart-1"
    Fiber.yield "chart-2"
  end
end

def apexcharts_id
  id_fiber.resume
end
