module Yardstick
  module V2Client
    class Authentication
      include RemoteModel

      attr_accessor :token

      def self.authenticate(email, password)
        response = put('/v2/auth/token', body: { email: email, password: password })
        new(token: response['token'])
      end
    end
  end
end
