module Yardstick
  module V2Client
    class ExamForm
      include RemoteModel
      attr_accessor :id, :name, :exam_id, :exam, :markers, :locked

      resource_uri '/v2/exam_forms'

      def self.assigned_to_me(token, options = {})
        query_collection(token, '/v2/whoami/exam_form_assignments', options)
      end

      def self.process_response(resp, extras = {})
        attrs = super
        attrs[:exam] = Exam.from_api(attrs[:exam]) if attrs.has_key?(:exam)
        attrs
      end
    end
  end
end
