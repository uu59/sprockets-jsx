require "rubygems"
require "bundler/setup"
Bundler.require(:default, :test)

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start
end

require File.expand_path("../../lib/sprockets-jsx.rb", __FILE__)

RSpec.configure do |conf|
  #conf.mock_with :rr
  #conf.include Rack::Test::Methods
  #conf.include Capybara::DSL

  FIXTURE_PATH = File.expand_path("../fixtures", __FILE__)
end
