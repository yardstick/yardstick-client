require 'ostruct'
require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class UserExamQuestion
      include RemoteModel

      attr_accessor :token,
                    :position,
                    :id,
                    :question_id,
                    :question,
                    :user_exam_id,
                    :user_exam,
                    :workflow_state,
                    :correct,
                    :score,
                    :points,
                    :score_tbd,
                    :paths,
                    :answer,
                    :state,
                    :html

      resource_uri '/v2/user_exam_questions'

      belongs_to_remote :user_exam, class: UserExam

      def self.process_response(resp, extras = {})
        attrs = super
        attrs.merge!(
          paths: OpenStruct.new(attrs[:paths]),
          answer: Answer.from_api(attrs[:answer]),
          question: Question.from_api(attrs[:question]),
        )
        attrs.merge!(user_exam: UserExam.from_api(attrs[:user_exam])) if attrs.has_key?(:user_exam)
        attrs
      end

      def self.for_user_exam(token, url, options = {})
        query_collection(token, url, options)
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
