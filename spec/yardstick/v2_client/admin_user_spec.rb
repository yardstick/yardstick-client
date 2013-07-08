require 'spec_helper'

describe Yardstick::V2Client::AdminUser do
  let(:admin_user) { Yardstick::V2Client::AdminUser }
  let(:token) { '12345' }
  let(:id) { 4 }
  let(:first_name) { 'Exam' }
  let(:last_name) { 'Marker' }
  let(:email) { 'marker@getyardstick.com' }
  let(:roles) { %w(marker something_else) }
  let(:account_id) { 49 }

  describe 'whoami' do
    it 'should return an instance of AdminUser representing the current user' do
      stub_path_response(:get, '/v2/admin_users/whoami', 200, {
        id: id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        roles: roles,
        account_id: account_id
      })

      me = admin_user.whoami(token)
      expect(me.id).to eq id
      expect(me.first_name).to eq first_name
      expect(me.last_name).to eq last_name
      expect(me.email).to eq email
      expect(me.roles).to eq roles
      expect(me.account_id).to eq account_id
    end

    it 'should raise an Unauthorized error when it gets a 401 back from measure' do
      stub_next_response(:get, 401)
      expect {
        admin_user.whoami('bad_token')
      }.to raise_error Yardstick::V2Client::Unauthorized
    end
  end

  describe 'all' do
    let(:stubbed_response) { [
        { id: id, first_name: first_name, last_name: last_name, email: email, roles: roles },
        { id: id + 1, first_name: 'Jim', last_name: 'Bob', email: 'jimbob@testing123.com', roles: roles }
      ]
    }

    it 'should return a list of AdminUsers' do
      stub_path_response(:get, '/v2/admin_users', 200, stubbed_response, token: token, roles: roles)

      admin_users = admin_user.all(token, roles)
      expect(admin_users.length).to be 2
      au = admin_users.last
      expect(au.first_name).to eq 'Jim'
      expect(au.last_name).to eq 'Bob'
      expect(au.email).to eq 'jimbob@testing123.com'
      expect(au.roles).to eq roles
    end
  end
end
