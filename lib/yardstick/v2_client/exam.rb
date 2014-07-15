module Yardstick
  module V2Client
    class Exam
      include RemoteModel
      attr_accessor :id, :name, :exam_forms, :marking_deadline_in_days

      alias_method :marking_deadline_in, :marking_deadline_in_days

      resource_uri '/v2/exams'

      def self.process_response(resp, extras = {})
        attrs = super
        attrs.merge!(:exam_forms, ExamForm.from_array(attrs[:exam_forms])) if attrs.has_key?(:exam_forms)
        attrs
      end
    end
  end
end
