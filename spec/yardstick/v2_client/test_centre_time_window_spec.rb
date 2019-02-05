require 'spec_helper'

describe Yardstick::V2Client::TestCentreTimeWindow do
  subject { Yardstick::V2Client::TestCentreTimeWindow }

  let(:token)       { 'abcdefg' }
  let(:id)          { Id.generate.to_s }
  let(:source_type) { 'Sitting' }

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

      expect(results[0].class).to eq(Yardstick::V2Client::AdminUser)
      expect(results[1].class).to eq(Yardstick::V2Client::Proctor)
      expect(results[2].class).to eq(Yardstick::V2Client::TestCentreManager)
    end
  end

  describe :apply do
    it 'should let the proctor apply' do
      stub_path_response(:put, "/v2/test_centre_time_windows/#{id}/apply", 200, {}, token: token, source_type: source_type)
      subject.apply(token, id, source_type)
    end
  end

  describe :withdraw do
    it 'should let the proctor withdraw' do
      stub_path_response(:put, "/v2/test_centre_time_windows/#{id}/withdraw", 200, {}, token: token, source_type: source_type)
      subject.withdraw(token, id, source_type)
    end
  end
end
