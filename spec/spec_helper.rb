require 'active_support'
require 'active_model'
require 'yardstick-client'

require 'mocha/api'
require 'yardstick/v2_client/testing'

RSpec.configure do |config|
  config.mock_with :mocha

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = "random"

  config.include Yardstick::V2Client::Testing::ApiStubHelpers
end
