module Yardstick
  module V2Client
    ##
    # Module intended to crash the HTTParty and take care of boring things like effectively
    # reporting error codes through exceptions.
    module PartyPooper
      extend ActiveSupport::Concern

      module ClassMethods
        def get(*args, &block)
          resp = super
          handle_common_codes(resp)
          resp
        end

        def put(*args, &block)
          resp = super
          handle_common_codes(resp)
          resp
        end

        def post(*args, &block)
          resp = super
          handle_common_codes(resp)
          resp
        end

        def handle_common_codes(resp)
          case resp.code
          when 401
            raise Unauthorized
          when 502
            raise MeasureServiceError, "Bad Gateway"
          when 500..1000
            raise MeasureServiceError, resp
          end
        end
      end
    end
  end
end
