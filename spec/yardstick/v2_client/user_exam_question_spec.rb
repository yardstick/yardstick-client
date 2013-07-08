require 'spec_helper'

describe Yardstick::V2Client::UserExamQuestion do
  let(:ueq) { Yardstick::V2Client::UserExamQuestion }
  let(:token) { 'abcdefg123345' }
  let(:user_exam_id) { 5 }
  let(:response) do
    [
      {
        answer: {
          user_exam_question_id: 5,
          score: nil,
          id: 5,
          capture: {
            know: 'blah',
            information: 'blah',
            model: 'blah'
          }
        },
        score_tbd: true,
        user_exam_id: user_exam_id,
        question_id: 18,
        correct: false,
        workflow_state: 'raw',
        score: 0,
        id: 5,
        points: 3
      }
    ]
  end

  describe :all_by_user_exam_id do
    it 'should return a list of user exam questions' do
      stub_path_response(:get, "/v2/user_exams/#{user_exam_id}/user_exam_questions", 200, response, token: token)

      ueqs = ueq.for_user_exam_id(token, user_exam_id)
      expect(ueqs.length).to eq 1

      r = ueqs.first

      expect(r.score_tbd).to be_true
      expect(r.question_id).to eq 18
      expect(r.id).to eq 5
      expect(r.points).to eq 3
    end

    it 'should accept an options param' do
      stub_path_response(:get, "/v2/user_exams/#{user_exam_id}/user_exam_questions", 200, response, token: token, marker: 'true')
      ueqs = ueq.for_user_exam_id(token, user_exam_id, marker: true)
      expect(ueqs.length).to eq 1
    end
  end
end
