require 'yardstick/v2_client/remote_model'

module Yardstick
  module V2Client
    class Answer
      include RemoteModel

      attr_accessor :id, :user_exam_question_id, :score, :capture
    end
  end
end
