require 'yardstick/v2_client/booking_request'

module Yardstick
  module V2Client
    class BookingRequest
      include RemoteModel

      attr_accessor :token
      attr_accessor :id, :venue_id, :date1_am, :date2_am, :date3_am, :state, :user_id, :grant_id
      attr_accessor :date1, :date2, :date3, :local_start_at, :local_end_at, :time_zone
      attr_accessor :user
      attr_accessor :time_required_in_minutes, :session_name, :booked_days_in_advance

      alias_method :time_required_in, :time_required_in_minutes

      def self.process_response(resp, extras = {})
        attrs = super
        [:date1, :date2, :date3].each do |date|
          attrs[date] = Date.parse(attrs[date]) if attrs[date].present?
        end
        attrs[:local_start_at] = DateTime.parse(attrs[:local_start_at]) if attrs[:local_start_at].present?
        attrs[:local_end_at] = DateTime.parse(attrs[:local_end_at]) if attrs[:local_end_at].present?
        attrs[:user] = User.from_api(attrs[:user]) if attrs[:user].present?
        attrs
      end

      def schedule(start_at)
        response = put(instance_action_uri(:schedule), body: {
          token: token,
          booking_request: {
            local_start_at: start_at.utc.iso8601
          }
        })

        update_attributes(response)
      end

      def request_alternate_dates(params)
        response = put(instance_action_uri(:request_alternate_dates), body: {
          token: token,
          booking_request: {
            date1: params[:date1],
            date1_am: params[:date1_am],
            date2: params[:date2],
            date2_am: params[:date2_am],
            date3: params[:date3],
            date3_am: params[:date3_am]
          }
        })

        update_attributes(response)
      end

      resource_uri '/v2/booking_requests'
    end
  end
end
