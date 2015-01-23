require 'spec_helper'

describe Yardstick::V2Client::Authentication do

  let(:authentication) { Yardstick::V2Client::Authentication }
  let(:token) { '12345' }

  ['authenticate', 'proctoring'].each do |method|
    describe method do
      it 'should return an authentication instance when token retrieval is successful' do
        stub_next_response(:put, 200, token: token)
        auth = authentication.send(method, 'marker@getyardstick.com', 'password')
        expect(auth.token).to eq token
      end

      it 'should return the error message when credentials are wrong' do
        stub_next_response(:put, 401)
        expect {
          authentication.send(method, 'marker@getyardstick.com', 'wrong password')
        }.to raise_error Yardstick::V2Client::Unauthorized
      end
    end

    it 'should raise password expiry error' do
      stub_next_response(:put, 449, error: 'blah blah', reason: 'password_expired', url: '/path_to_password_reset')
      expect {
        authentication.send(method, 'proctor@getyardstick.com', 'expired password')
      }.to raise_error Yardstick::V2Client::PasswordExpiredError
    end
  end
end
