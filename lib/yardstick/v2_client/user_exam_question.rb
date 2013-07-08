require 'ostruct'

module Yardstick
  module V2Client
    class UserExamQuestion
      include RemoteModel

      attr_accessor :token, :position, :id, :question_id, :question, :user_exam_id, :user_exam, :workflow_state, :correct, :score, :points, :score_tbd, :paths, :answer

      resource_uri '/v2/user_exam_questions'

      def self.from_api(resp, extras = {})
        resp = resp.parsed_response if resp.respond_to?(:parsed_response)
        attrs = resp.with_indifferent_access
        attrs.merge!(extras)
        attrs.merge!(
          paths: OpenStruct.new(attrs[:paths]),
          answer: Answer.from_api(attrs[:answer]),
          question: Question.from_api(attrs[:question])
        )
        attrs.merge!(user_exam: UserExam.from_api(attrs[:user_exam])) if attrs[:user_exam].present?
        new(attrs)
      end

      def self.for_user_exam(token, url, options = {})
        response = get(url, body: options.merge(token: token))
        response.map { |ueq| from_api(ueq, token: token) }
      end

      def self.for_user_exam_id(token, user_exam_id, options = {})
        for_user_exam(token, "/v2/user_exams/#{user_exam_id}/user_exam_questions", options)
      end

      def question(options = {})
        @question ||= begin
          Question.find_by_url(paths.question, options.merge(token: token, user_exam_id: user_exam_id))
        end
      end
    end
  end
end
