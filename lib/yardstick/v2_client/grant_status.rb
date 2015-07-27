module Yardstick
  module V2Client
    class GrantStatus
      include RemoteModel

      attr_accessor :response # TODO: refactor this up so it's available to other models

      resource_uri '/v2/grant_status'

      attr_accessor :writable, :exam_url, :status, :user_id, :id

      alias_method :writable?, :writable

      def update
        self.response = put(instance_uri, body: {
          token: token,
          grant_status: {
            status: status
          }
        })
        self
      end

      [:complete, :force_terminate].each do |action|
        define_method(action) do
          self.response = put(instance_action_uri(action), body: {
            token: token,
            grant_status: {
              status: status
            }
          })
        end
      end
    end
  end
end
