require 'spec_helper'

describe Yardstick::V2Client do
  let(:token) { '12345666666666' }
  describe :whoami do
    it 'should be successful' do
      stub_path_response(:get, '/v2/whoami', 200, { id: 300, first_name: 'Something', last_name: 'Interesting', klass: 'AdminUser' }, token: token)
      result = Yardstick::V2Client.whoami(token)
      expect(result.first_name).to eq('Something')
      expect(result.last_name).to eq('Interesting')
      expect(result.id).to eq(300)
    end

    %w(User AdminUser).each do |user_type|
      context "for a(n) #{user_type}" do
        let(:user_attributes) do
          {
            :id => 33, # yum
            :first_name => 'Nucky',
            :last_name => 'Thompson',
            :email => 'nucky@theboardwalk.at',
            :klass => user_type
          }
        end

        subject { Yardstick::V2Client.whoami('some token') }

        it 'should ask the klass attribute for where to get the class from' do
          stub_path_response(:get, '/v2/whoami', 200, user_attributes)

          expect(subject.class).to eq(Yardstick::V2Client.const_get(user_type))
          expect(subject.id).to eq(user_attributes[:id])
          expect(subject.email).to eq(user_attributes[:email])
          expect(subject.first_name).to eq(user_attributes[:first_name])
          expect(subject.last_name).to eq(user_attributes[:last_name])
        end
      end
    end
  end
end
