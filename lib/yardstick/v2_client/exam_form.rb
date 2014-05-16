module Yardstick
  module V2Client
    class ExamForm
      include RemoteModel
      attr_accessor :id, :name, :exam_id, :exam

      def self.assigned_to_me(token)
        response = get('/v2/whoami/exam_form_assignments', :query => { :token => token })
        ExamForm.from_array(response)
      end

      def self.process_response(resp, extras = {})
        attrs = super
        attrs[:exam] = Exam.from_api(attrs[:exam]) if attrs.has_key?(:exam)
        attrs
      end
    end
  end
end
