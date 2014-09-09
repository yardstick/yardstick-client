require 'yardstick/v2_client/booking_request'

module Yardstick
  module V2Client
    class BookingRequest
      include RemoteModel

      attr_accessor :id, :venue_id, :date1_am, :date2_am, :date3_am, :state, :user_id, :grant_id
      attr_accessor :date1, :date2, :date3, :local_end_at
      attr_accessor :user
      attr_accessor :time_required_in_minutes, :session_name

      alias_method :time_required_in, :time_required_in_minutes 

      def self.process_response(resp, extras = {})
        attrs = super
        [:date1, :date2, :date3].each do |date|
          attrs[date] = Date.parse(attrs[date])
        end
        attrs[:local_end_at] = DateTime.iso8601(attrs[:local_end_at]) if attrs[:local_end_at].present?
        attrs[:user] = User.from_api(attrs[:user])
        attrs
      end

      resource_uri '/v2/booking_requests'
    end
  end
end
