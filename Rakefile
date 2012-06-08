require File.expand_path("../spec/spec_helper.rb", __FILE__)

require "rspec/core/rake_task"
require "rspec/core/version"

task :default => :spec

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  #t.ruby_opts = %w[-w]
end
