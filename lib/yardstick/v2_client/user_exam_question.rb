require 'ostruct'
require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class UserExamQuestion
      include RemoteModel

      attr_accessor :token, :position, :id, :question_id, :question, :user_exam_id, :user_exam, :workflow_state, :correct, :score, :points, :score_tbd, :paths, :answer, :state

      resource_uri '/v2/user_exam_questions'

      def self.process_response(resp, extras = {})
        attrs = super
        attrs.merge!(
          paths: OpenStruct.new(attrs[:paths]),
          answer: Answer.from_api(attrs[:answer]),
          question: Question.from_api(attrs[:question])
        )
      end

      def self.for_user_exam(token, url, options = {})
        response = get(url, query: options.merge(token: token))
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
