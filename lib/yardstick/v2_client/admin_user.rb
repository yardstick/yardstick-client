require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class AdminUser
      include RemoteModel
      attr_accessor :first_name, :last_name, :id, :email, :roles, :account_id, :token

      resource_uri '/v2/admin_users'

      def self.whoami(token)
        response = get('/v2/admin_users/whoami', query: { token: token })
        AdminUser.new(response.parsed_response.merge(token: token))
      end

      # TODO: refactor this to make it more consistent with the rest of the all calls
      def self.all(token, roles)
        super(token, roles: roles)
      end
    end
  end
end
