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

  describe :typed_resource_uri do
    it 'should generate URIs for the "subclass" end points' do
      time_window = subject.new(:source_id => 18, :source_type => 'BookingRequest')
      expect(time_window.send(:typed_resource_uri)).to eq('/v2/booking_requests/18')

      time_window = subject.new(:source_id => 21, :source_type => 'Sitting')
      expect(time_window.send(:typed_resource_uri)).to eq('/v2/sittings/21')
    end

    it 'should append the action if provided' do
      time_window = subject.new(:source_id => 33, :source_type => 'Meal')
      expect(time_window.send(:typed_resource_uri, :order)).to eq('/v2/meals/33/order')
    end
  end
end
