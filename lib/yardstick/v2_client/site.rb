require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Site
      include RemoteModel
      attr_accessor :id, :short_name, :name, :domain, :unlock_url

      resource_uri '/v2/sites'

      def self.process_response(resp, extras = {})
        super
      end
    end
  end
end
