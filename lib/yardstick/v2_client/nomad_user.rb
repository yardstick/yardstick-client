require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class NomadUser
      include RemoteModel

      attr_accessor :id, :email, :first_name, :last_name, :roles, :token

      def self.authenticate(username, password)
        response = put('/v2/nomad_users/auth', body: { email: username, password: password })
        from_api(response)
      end

      def self.whoami(token)
        response = get('/v2/nomad_users/whoami', query: { token: token })
        from_api(response, token: token)
      end
    end
  end
end
