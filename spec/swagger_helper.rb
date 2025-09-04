# frozen_string_literal: true

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Customers API',
        version: 'v1'
      },
      paths: {},
      servers: [
        { url: 'http://localhost:3000', description: 'Local server' }
      ]
    }
  }
  config.openapi_format = :yaml
end
