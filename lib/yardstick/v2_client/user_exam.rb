require 'ostruct'
require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class UserExam
      include RemoteModel
      attr_accessor :token, :id, :paths, :user, :user_id, :exam_id, :exam_form_id, :finished_at, :language_name, :marking_sessions

      belongs_to_remote :exam, class: Exam
      belongs_to_remote :exam_form, class: ExamForm

      resource_uri '/v2/user_exams'

      def self.process_response(resp, extras = {})
        attrs = super
        attrs.merge!(paths: OpenStruct.new(attrs[:paths]))
        attrs.merge!(finished_at: DateTime.iso8601(attrs[:finished_at])) unless attrs[:finished_at].nil?
        attrs
      end

      def self.count(token, options = {})
        response = get('/v2/user_exams/count', query: options.merge(token: token))
        response['count']
      end

      def self.due_dates(token, options = {})
        response = get('/v2/user_exams/count/group_by/due_dates', query: options.merge(token: token))
        response.parsed_response
      end

      def user_exam_questions(options = {})
        @user_exam_questions ||= begin
          options.fetch(:klass) { UserExamQuestion }.for_user_exam(token, paths.user_exam_questions, options.except(:klass))
        end
      end

      def mark_all(marks_as_hash)
        put("/v2/user_exams/#{id}/user_exam_questions/mark", body: {
          token: token,
          marks: marks_as_hash # some reason HTTParty will only accept this as hash.. other wise measure throws marks param invalid error
        })
      end
    end
  end
end
