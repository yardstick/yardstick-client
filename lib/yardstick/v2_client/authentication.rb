require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Authentication
      include RemoteModel

      attr_accessor :token

      def self.authenticate(email, password, options = {})
        response = put('/v2/auth/token', body: options.merge({ email: email, password: password }))
        new(token: response['token'])
      end
    end
  end
end
