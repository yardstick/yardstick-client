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

      resource_uri '/v2/users'

      def self.find(token, user_id, id)
        from_api(get("#{resource_uri}/#{user_id}/grants/#{id}", query: { token: token }), token: token)
      end

<<<<<<< HEAD
      def self.all(token, user_id, options = {})
        uri = "#{resource_uri}/#{user_id}/grants"
=======
      def self.all(token, index, options = {})
        uri = "#{resource_uri}/#{index}"
>>>>>>> ced9f2dec71d5fe6dfc39cdff9d3d5ac63ac2ff1
        query_collection(token, uri, options)
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
