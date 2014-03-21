require 'spec_helper'

describe Yardstick::V2Client::NomadUser do
  subject { Yardstick::V2Client::NomadUser }

  let(:token) { 'blah' }
  let(:email) { 'bill@123.com' }
  let(:response) { {
    id: Id.generate,
    email: email,
    first_name: 'Bill',
    last_name: 'Notbob',
    roles: 'proctor'
  } }

  describe :authenticate do
    it 'should return an auth object' do
      stub_path_response(:put, '/v2/nomad_users/auth', 200, { token: token }, email: email, password: 'password')
      result = subject.authenticate(email, 'password')
      expect(result.token).to eq(token)
    end
  end

  describe :whoami do
    it 'should return a nomad user' do
      stub_path_response(:get, '/v2/nomad_users/whoami', 200, response, token: token)
      user = subject.whoami(token)
      expect(user.email).to eq(email)
      expect(user.first_name).to eq(response[:first_name])
      expect(user.token).to eq(token)
    end
  end
end
