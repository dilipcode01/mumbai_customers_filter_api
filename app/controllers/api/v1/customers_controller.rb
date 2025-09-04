# frozen_string_literal: true

# app/controllers/api/v1/customers_controller.rb
module Api
  module V1
    class CustomersController < ApplicationController
      def invite
        file = params[:file]
        return render json: { error: 'File missing' }, status: :bad_request unless file

        customers = CustomerFilter.new(file.path).call
        render json: customers, status: :ok
      rescue StandardError => e
        Rails.logger.error "Invite processing failed: #{e.message}"
        render json: { error: 'Internal server error' }, status: :internal_server_error
      end
    end
  end
end
