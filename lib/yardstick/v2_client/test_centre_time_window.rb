require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class TestCentreTimeWindow
      include RemoteModel

      resource_uri '/v2/test_centre_time_windows'

      attr_accessor :venue, :venue_id, :attachments, :global_start_datetime, :global_end_datetime, :source_id, :source_type, :time_zone

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
          :global_start_datetime => DateTime.iso8601(attrs[:global_start_datetime])
        )
      end

      def self.upcoming_and_recent(token)
        resp = get("#{resource_uri}/upcoming_and_recent", query: { token: token })
        resp.map { |o| from_api(o) }
      end
    end
  end
end
