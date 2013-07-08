require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Answer
      include RemoteModel

      attr_accessor :id, :user_exam_question_id, :score, :capture

      def self.from_api(attrs)
        new(attrs)
      end
    end
  end
end
