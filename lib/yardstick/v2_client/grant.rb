require 'yardstick/v2_client/remote_model'
require 'yardstick/cacheable'

module Yardstick
  module V2Client
    class Grant
      include RemoteModel
      include Cacheable

      cached_accessor :id

      attr_accessor :metadata,
                    :start_at,
                    :expire_at,
                    :allow_sittings_start_at,
                    :allow_sittings_end_at,
                    :time_zone_name,
                    :exam_form_id,
                    :send_email,
                    :exam_form_group,
                    :num_uses

      def self.find(token, user_id, id)
        resource_uri "/v2/users/#{user_id}/grants"
        super(token, id)
      end

      def update(params)
        self.response = put(
          instance_uri,
          body: {
            token: token,
            grant: params
          }
        )
        self
      end
    end
  end
end
