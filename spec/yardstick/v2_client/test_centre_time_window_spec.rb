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

  describe :proctors do
    it 'create the right type of proctors' do
      stub_path_response(:get, '/v2/sittings/83/proctors', 200, [{
          id: 53,
          first_name: 'Bruce',
          last_name: 'Wayne',
          email: 'doyouwanttoknowmysecretidentity@wayneenterprises.com',
          type: 'AdminUser',
          roles: ['proctor']
        }, {
          id: 82,
          first_name: 'Clark',
          last_name: 'Kent',
          email: 'ckent@dailyplanet.com',
          type: 'Proctor'
        }, {
          id: 38,
          first_name: 'Lois',
          last_name: 'Lane',
          email: 'lois@dailyplanet.com',
          type: 'TestCentreManager',
        }], token: token)
      window = subject.new(source_id: 83, source_type: 'Sitting', token: token, paths: subject::Paths.new(proctors: '/v2/sittings/83/proctors'))
      results = window.proctors
      expect(results.length).to eq(3)
    end
  end
end
