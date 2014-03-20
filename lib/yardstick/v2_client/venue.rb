require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Venue
      include RemoteModel

      attr_accessor :location, :id, :account, :account_id

      def self.process_response(resp, extras = {})
        attrs = super
        attrs.merge!(
          :account => Account.from_api(attrs[:account])
        )
      end
    end
  end
end
