module Yardstick
  module V2Client
    class Exam
      include RemoteModel
      attr_accessor :id, :name, :exam_forms

      resource_uri '/v2/exams'

      def process_response(resp, extras = {})
        attrs = super
        attrs.merge!(:exam_forms, attrs[:exam_forms].map { |f| ExamForm.from_api(f) })
      end
    end
  end
end
