require 'spec_helper'

describe Yardstick::V2Client::GrantStatus do
  let(:gs_client) { Yardstick::V2Client::GrantStatus }
  let(:token) { 'abssclklkjlkj' }

  describe :find do
    it 'should populate the token as part of the response handling' do
      stub_path_response(:get, '/v2/grant_status/100', 200, { id: 100 }, token: token)

      status = gs_client.find(token, 100)

      expect(status.token).to eq(token)
    end
  end

  describe :force_terminate do
    it 'should be able to call the method without passing in the token' do
      stub_path_response(:put, '/v2/grant_status/100/force_terminate', 200, { id: 100 }, token: token, grant_status: { status: 'veni vidi vici' })
      status = gs_client.new(id: 100, status: 'veni vidi vici', token: token)
      status.force_terminate

      expect(status.response.code).to eq(200)
    end
  end
end
