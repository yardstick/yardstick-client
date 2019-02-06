require 'spec_helper'

describe Yardstick::V2Client::UserExam do
  let(:ue_client) { Yardstick::V2Client::UserExam }
  let(:token) { 'abcdefg' }

  describe :all do
    it 'should return a list of exams' do
      stub_path_response(:get, '/v2/user_exams', 200, [{ id: 1 }, { id: 2 }, { id: 5 }], token: token)

      user_exams = ue_client.all(token)

      expect(user_exams.length).to eq 3
      expect(user_exams.first.id).to eq 1
      expect(user_exams.last.id).to eq 5
    end

    it 'should take in an options hash for parameters such as limit, except, etc.' do
      stub_path_response(:get, '/v2/user_exams', 200, [{ id: 3 }], token: token, limit: '1', except: %W{2 4})

      user_exams = ue_client.all(token, limit: 1, except: [2, 4])
      expect(user_exams.length).to eq 1
      expect(user_exams.first.id).to eq 3
    end
  end

  describe :count do
    it 'should call the count api with options like all' do
      stub_path_response(:get, '/v2/user_exams/count', 200, { count: 3 }, administration_id: '1', token: token)
      expect(ue_client.count(token, administration_id: 1)).to eq 3
    end
  end

  describe 'user_exam_questions' do
    let(:token) { 'token' }
    let(:path) { 'path-to-user-exam-questions' }
    let(:paths) { stub('paths', user_exam_questions: path) }
    let(:user_exam) { ue_client.new(token: token, paths: paths) }
    let(:user_exam_question) { stub('UserExamQuestion') }
    let(:batman) { 'batman' }

    it 'should retrieve user_exam_questions from an instance' do
      user_exam_question.expects(:for_user_exam).with(token, path, {}).returns(batman)
      expect(user_exam.user_exam_questions(klass: user_exam_question)).to eq batman
    end

    it 'should cache user_exam_questions' do
      user_exam_question.expects(:for_user_exam).once.with(token, path, {}).returns(batman)
      expect(user_exam.user_exam_questions(klass: user_exam_question)).to eq batman
      expect(user_exam.user_exam_questions(klass: user_exam_question)).to eq batman
    end
  end

  describe '#mark_all' do
    let(:token) { '123456' }
    let(:the_marks) { 'the_marks' }

    it 'should put the scores' do
      ue = ue_client.new(id: 9, token: token)
      stub_path_response(:put, '/v2/user_exams/9/user_exam_questions/mark', 200, {}, token: token, marks: the_marks, email_exam_result_after_marking: 'true')
      ue.mark_all(the_marks, email_exam_result_after_marking: 'true')
    end
  end
end
