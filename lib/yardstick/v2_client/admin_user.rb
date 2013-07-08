require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class AdminUser
      include RemoteModel

      attr_accessor :first_name, :last_name, :id, :email, :roles, :account_id, :token

      def self.whoami(token)
        response = get('/v2/admin_users/whoami', body: { token: token })
        AdminUser.new(response.parsed_response.merge(token: token))
      end

      def self.all(token, roles)
        response = get('/v2/admin_users', body: { token: token, roles: roles })
        response.map { |au| AdminUser.new(au) }
      end
    end
  end
end
