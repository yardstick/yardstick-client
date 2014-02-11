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
  end
end
