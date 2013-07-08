require 'spec_helper'

describe Yardstick::V2Client::Administration do
  let(:administration) { Yardstick::V2Client::Administration }
  let(:token) { '5550134' }

  describe 'all' do
    let(:a1response) do
      { id: FactoryGirl.generate(:id), name: 'June 2013 Administration', site_id: FactoryGirl.generate(:id) }
    end
    let(:a2response) do
      { id: FactoryGirl.generate(:id), name: 'December 2013 Administration', site_id: FactoryGirl.generate(:id) }
    end
    it 'should return a list of administrations from measure' do
      stub_path_response(:get, '/v2/administrations', 200, [a1response, a2response], token: token)
      administrations = administration.all(token)
      expect(administrations.length).to eq 2
      names = administrations.map(&:name)
      expect(names).to include a1response[:name]
      expect(names).to include a2response[:name]
    end
  end
end