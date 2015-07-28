require 'spec_helper'

describe Yardstick::V2Client::RemoteModel do
  subject { Yardstick::V2Client::UserExamQuestion }

  describe :respond_to_missing? do
    it 'should respond to all_by_whatever attribute' do
      expect(subject).to respond_to :all_indexed_on_id
    end
  end

  describe :error_handling do
    it 'should raise a measure service error when reason is not handled' do
      stub_path_response(:get, '/v2/user_exam_questions', 449, { reason: 'an unhandled reason' }, token: 'a token')
      expect { subject.all('a token').to_a }.to raise_error(Yardstick::V2Client::MeasureServiceError)
    end

    it 'should handle 404s' do
      stub_path_response(:get, '/v2/user_exam_questions/9001', 404, { error: 'UEQ(9001) not found' }, token: 'secret')
      expect { subject.find('secret', 9001) }.to raise_error(Yardstick::V2Client::NotFound)
    end
  end
end
