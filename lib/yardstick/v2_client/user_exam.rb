require 'ostruct'
require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class UserExam
      include RemoteModel

      attr_accessor :token, :id, :paths, :user

      def self.from_api(resp, extras = {})
        resp = resp.parsed_response if resp.respond_to?(:parsed_response)
        attrs = resp.with_indifferent_access
        attrs.merge!(extras)
        attrs.merge!(paths: OpenStruct.new(attrs[:paths]))
        new(attrs)
      end

      def self.all(token, options = {})
        response = get('/v2/user_exams', body: options.merge(token: token))
        response.map { |ue| from_api(ue, token: token) }
      end

      def self.count(token, options = {})
        response = get('/v2/user_exams/count', body: options.merge(token: token))
        response['count']
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
