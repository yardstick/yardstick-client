require 'spec_helper'

describe Yardstick::V2Client::ExamForm do
  describe :assigned_to_me do
    let(:response) do
      [
        { id: Id.generate, name: 'Form #1c', :exam_id => Id.generate },
        { id: Id.generate, name: 'Form #2b', :exam_id => Id.generate },
        { id: Id.generate, name: 'Form #3a', :exam_id => Id.generate }
      ]
    end
    let(:token) { '0809230984' }

    subject { Yardstick::V2Client::ExamForm.assigned_to_me(token) }

    before do
      stub_path_response(:get, '/v2/whoami/exam_form_assignments', 200, response, token: token)
    end

    it 'should return a list of forms' do
      subject.each_with_index do |form, i|
        expect(form.id).to eq(response[i][:id])
        expect(form.name).to eq(response[i][:name])
        expect(form.exam_id).to eq(response[i][:exam_id])
      end
    end
  end
end
