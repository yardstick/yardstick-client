require 'spec_helper'

describe Yardstick::V2Client::Passage do
  let(:passage) { Yardstick::V2Client::Passage }
  let(:token) { '109812093' }
  let(:item_bank_id) { Id.generate }
  let(:p1) do
    { id: Id.generate, name: 'Case 0051', created_by_id: Id.generate, item_bank_id: item_bank_id }
  end
  let(:p2) do
    { id: Id.generate, name: 'Case 0029', created_by_id: Id.generate, item_bank_id: item_bank_id }
  end

  describe 'all' do
    it 'should return a list of passages from measure' do
      stub_path_response(:get, '/v2/passages', 200, [p1, p2], token: token)

      passages = passage.all(token)

      expect(passages.length).to eq 2
      expect(passages.first.name).to eq 'Case 0051'
      expect(passages.last.name).to eq 'Case 0029'
    end

    it 'should take some options in' do
      stub_path_response(:get, '/v2/passages', 200, [p1, p2], token: token, administration_id: '11', with_manually_graded_questions: 'true')

      passages = passage.all(token, administration_id: 11, with_manually_graded_questions: true)
    end
  end

  describe 'all_indexed_on_id' do
    it 'should return a list of passages from measure and return a hash by id' do
      stub_path_response(:get, '/v2/passages', 200, [p1, p2], token: token)

      passages = passage.all_indexed_on_id(token)

      expect(passages.length).to eq 2
      expect(passages[p1[:id]].name).to eq 'Case 0051'
      expect(passages[p2[:id]].name).to eq 'Case 0029'
    end
  end
end
