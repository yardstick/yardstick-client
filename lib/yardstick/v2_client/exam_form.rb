module Yardstick
  module V2Client
    class ExamForm
      include RemoteModel
      attr_accessor :id, :name, :exam_id
    end
  end
end
