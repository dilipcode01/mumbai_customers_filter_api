# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Customers', type: :request do
  describe 'POST /api/v1/customers/invite' do
    let(:file) { fixture_file_upload('spec/fixtures/customers.txt', 'text/plain') }

    context 'when file is provided' do
      it 'returns filtered customers' do
        post '/api/v1/customers/invite', params: { file: file }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to include(
          { 'user_id' => 25, 'name' => 'Pratik' },
          { 'user_id' => 32, 'name' => 'Manish' }
        )
        expect(json).not_to include({ 'user_id' => 3, 'name' => 'Charlie' })
      end
    end

    context 'when file is missing' do
      it 'returns a bad_request error' do
        post '/api/v1/customers/invite'
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('File missing')
      end
    end
  end
end
