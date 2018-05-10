require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class TestCentreTimeWindow
      include RemoteModel

      class Paths < Yardstick::ActiveModel::Base
        attr_accessor :users, :proctors, :incidents
      end

      resource_uri '/v2/test_centre_time_windows'

      attr_accessor :venue, :venue_id, :attachments, :global_start_datetime, :global_end_datetime, :source_id,
                    :source_type, :time_zone, :proctoring_options, :available_to_apply, :pending_proctor_ids,
                    :confirmed_proctor_ids
      attr_accessor :incident_ids, :incidents, :test_centre_seats
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
        from_api(get(uri, query: { token: token }), token: token)
      end

      def create_incident(incident)
        response = Incident.post(paths.incidents, body: {
          token: token,
          incident: incident
        })
        Incident.from_api(response)
      end

      def incidents
        @incidents ||= Incident.query_collection(token, paths.incidents)
      end

      def users
        @users ||= User.query_collection(token, paths.users)
      end

      def proctors
        @proctors ||= CollectionProxy.new do
          resp = self.class.get_all(token, paths.proctors)
          resp.map do |e|
            e = e.dup
            type = e.extract!('type')['type']
            Yardstick::V2Client.const_get(type).from_api(e)
          end
        end
      end

      def apply
        response = put(instance_action_uri(:apply), body: {
          token: token,
          id: params[:source_id],
          source_type: params[:source_type]
        })

        update_attributes(response)
      end
    end
  end
end
