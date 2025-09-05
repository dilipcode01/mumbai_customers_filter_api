# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      def invite
        file = customer_params[:file]
        return render json: { error: 'File missing' }, status: :bad_request unless file.present?

        @customers = NearbyCustomersFinder.new(customer_params).call
      rescue StandardError => e
        Rails.logger.error "Invite processing failed: #{e.message}"
        render json: { error: 'Internal server error' }, status: :internal_server_error
      end

      private

      def customer_params
        params.permit(:file, :lat, :lon, :max_distance_km)
      end
    end
  end
end
