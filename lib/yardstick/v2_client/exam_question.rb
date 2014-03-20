module Yardstick
  module V2Client
    class ExamQuestion
      include RemoteModel
      attr_accessor :token, :id, :exam_form_id, :exam_form, :question_id, :question, :position

      def self.process_response(resp, extras = {})
        attrs = super
        attrs[:question] = Question.from_api(attrs[:question]) if attrs.has_key?(:question)
        attrs
      end

      def self.for_exam_form_id(token, exam_form_id, options = {})
        response = get("/v2/exam_forms/#{exam_form_id}/exam_questions", query: options.merge(token: token))
        response.map { |eq| from_api(eq, token: token) }
      end
    end
  end
end
