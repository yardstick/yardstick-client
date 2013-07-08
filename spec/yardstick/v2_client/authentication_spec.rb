require 'spec_helper'

describe Yardstick::V2Client::Authentication do

  let(:authentication) { Yardstick::V2Client::Authentication }
  let(:token) { '12345' }

  describe 'authenticate' do
    it 'should return an authentication instance when token retrieval is successful' do
      stub_next_response(:put, 200, token: token)
      auth = authentication.authenticate('marker@getyardstick.com', 'password')
      expect(auth.token).to eq token
    end

    it 'should return the error message when credentials are wrong' do
      stub_next_response(:put, 401)
      expect {
        authentication.authenticate('marker@getyardstick.com', 'wrong password')
      }.to raise_error Yardstick::V2Client::Unauthorized
    end
  end
end
