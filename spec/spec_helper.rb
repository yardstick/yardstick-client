ENV['MEASURE_BASE_URL'] = 'https://test.localhost'
require 'active_support/all'
require 'active_model'
require 'yardstick-client'
require 'json'

require 'mocha/api'
require 'pry'
require 'yardstick/v2_client/testing'

Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |f|
  require Pathname.new(f).relative_path_from(Pathname.new(File.dirname(__FILE__)))
end

RSpec.configure do |config|
  config.mock_with :mocha

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = "random"

  config.include Yardstick::V2Client::Testing::ApiStubHelpers
end
