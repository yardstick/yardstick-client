require 'webmock/rspec'

module Yardstick
  module V2Client
    module Testing
      module ApiStubHelpers
        def stub_api_response(method, url, code, body = {}, request_params = {})
          stub_request(method, url).
            with(param_type(method) => request_params).
            to_return({
              body: body.to_json,
              status: code,
              headers: {
                'Content-Type' => 'application/json'
              }
            })
        end

        def stub_path_response(method, path, code, body = {}, request_body = {})
          stub_api_response(method, "#{ENV['MEASURE_BASE_URL']}#{path}", code, body, request_body)
        end

        def stub_next_response(method, code, body = {}, request_body = {})
          stub_api_response(method, /.*/, code, body, request_body)
        end

      private

        def param_type(method)
          case method
          when :post, :put
            :body
          else
            :query
          end
        end
      end
    end
  end
end
