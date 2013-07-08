require 'spec_helper'

describe Yardstick::V2Client::RemoteModel do
  subject { Yardstick::V2Client::UserExamQuestion }

  describe :respond_to_missing? do
    it 'should respond to all_by_whatever attribute' do
      expect(subject).to respond_to :all_indexed_on_id
    end
  end
end
