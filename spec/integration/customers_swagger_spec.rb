# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Customers API', type: :request do
  path '/api/v1/customers/invite' do
    post 'Filter customers from a file' do
      tags 'Customers'
      consumes 'multipart/form-data'
      parameter name: :file, in: :formData, type: :file, description: 'Text file with JSON customer data'

      response '200', 'customers filter successfully' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   user_id: { type: :integer },
                   name: { type: :string }
                 },
                 required: %w[user_id name]
               }

        let(:file) { Rack::Test::UploadedFile.new('spec/fixtures/customers.txt', 'text/plain') }
        run_test!
      end

      response '400', 'file missing' do
        let(:file) { nil }
        run_test!
      end
    end
  end
end
