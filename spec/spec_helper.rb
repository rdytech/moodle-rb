require 'bundler/setup'
Bundler.require(:default, :development)

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.filter_run_excluding :perf => true
  config.order = 'random'
end

require 'webmock/rspec'
RSpec.configure do |config|
  config.before(:each) do
    WebMock.disable_net_connect!
  end
end

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

require File.expand_path('../../lib/moodle.rb', __FILE__)
