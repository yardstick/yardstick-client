require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class ExamDeliveryStatusMessage
      include RemoteModel

      resource_uri '/v2/exam_delivery_status_messages'

      attr_accessor :id, :message_text, :message_type, :created_at

      def self.process_response(resp, extras = {})
        attrs = super
        attrs.merge!(created_at: DateTime.iso8601(attrs[:created_at]))
      end
    end
  end
end
