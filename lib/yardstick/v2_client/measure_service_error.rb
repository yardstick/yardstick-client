module Yardstick
  module V2Client
    class MeasureServiceError < StandardError
    end

    module RetryWith
      extend self

      def from_api(resp)
        resp = resp.parsed_response if resp.respond_to?(:parsed_response)
        case resp['reason']
        when 'password_expired'
          PasswordExpiredError.new(resp['url'])
        else
          MeasureServiceError.new("Unknown retry with reason: #{resp['reason']}")
        end
      end
    end

    class PasswordExpiredError < MeasureServiceError
      attr_reader :password_reset_path

      def initialize(url)
        @password_reset_path = url
      end
    end
  end
end
