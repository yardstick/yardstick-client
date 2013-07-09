require 'webmock/rspec'

module Yardstick
  module V2Client
    module Testing
      module ApiStubHelpers
        def stub_api_response(method, url, code, body = {}, request_body = {})
          stub_request(method, url).
            with(body: request_body).
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
      end
    end
  end
end
