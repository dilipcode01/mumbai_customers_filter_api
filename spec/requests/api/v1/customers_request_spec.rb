# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Customers API', type: :request do
  path '/api/v1/customers/invite' do
    post 'Filter customers from a file' do
      tags 'Customers'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: :file, in: :formData, type: :file, description: 'Text file with JSON customer data',
                required: true

      response '200', 'customers filtered successfully' do
        let(:file) { fixture_file_upload(Rails.root.join('spec/fixtures/customers.txt'), 'text/plain') }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to all(include('user_id', 'name'))
          expect(data).to include(a_hash_including('user_id' => 25, 'name' => 'Pratik'))
          expect(data).not_to include(a_hash_including('user_id' => 3, 'name' => 'Charlie'))
        end
      end

      response '400', 'file missing' do
        let(:file) { nil }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['error']).to eq('File missing')
        end
      end
    end
  end
end
