require 'spec_helper'

describe Yardstick::V2Client::TestCentreTimeWindow do
  subject { Yardstick::V2Client::TestCentreTimeWindow }

  let(:token) { 'abcdefg' }

  describe :upcoming_and_recent do
    it 'should be a proper get request' do
      stub_path_response(:get, '/v2/test_centre_time_windows/upcoming_and_recent', 200, [], token: token)
      expect(subject.upcoming_and_recent(token)).to eq([])
    end
  end
end
