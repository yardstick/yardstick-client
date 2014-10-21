require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class TestCentreTimeWindow
      include RemoteModel

      class Paths < Yardstick::ActiveModel::Base
        attr_accessor :users, :proctors, :incidents
      end

      resource_uri '/v2/test_centre_time_windows'

      attr_accessor :venue, :venue_id, :attachments, :global_start_datetime, :global_end_datetime, :source_id, :source_type, :time_zone
      attr_accessor :token
      attr_accessor :paths

      def local_start_datetime
        global_start_datetime.in_time_zone(ActiveSupport::TimeZone[time_zone])
      end

      def local_end_datetime
        global_end_datetime.in_time_zone(ActiveSupport::TimeZone[time_zone])
      end

      def self.process_response(resp, extra = {})
        attrs = super
        attrs.merge!(
          :venue => Venue.from_api(attrs[:venue]),
          :attachments => attrs[:attachments].map { |o| Attachment.from_api(o) },
          :global_end_datetime => DateTime.iso8601(attrs[:global_end_datetime]),
          :global_start_datetime => DateTime.iso8601(attrs[:global_start_datetime]),
          :paths => Paths.new(attrs[:paths])
        )
      end

      def self.upcoming_and_recent(token)
        query_collection(token, "#{resource_uri}/upcoming_and_recent")
      end

      def self.find_by_source(token, source)
        uri = instance_action_uri(source[:source_id], source[:source_type].underscore)
        from_api(get(uri, query: { token: token}), token: token)
      end

      def proctors
        NomadUser.query_collection(token, typed_resource_uri(:proctors))
      end

      def users
        User.query_collection(token, paths.users)
      end

      def proctors
        NomadUser.query_collection(token, paths.proctors)
      end
    end
  end
end
