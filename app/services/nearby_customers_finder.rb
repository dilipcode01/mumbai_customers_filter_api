# app/services/customer_filter_service.rb
# frozen_string_literal: true

require 'json'

class NearbyCustomersFinder
  DEFAULT_COORDINATES = { lat: 19.0590317, lon: 72.7553452 }.freeze
  DEFAULT_MAX_DISTANCE = 100

  def initialize(params)
    @file_path = params[:file]&.path
    @lat = params[:lat].presence&.to_f || DEFAULT_COORDINATES[:lat]
    @lon = params[:lon].presence&.to_f || DEFAULT_COORDINATES[:lon]
    @max_distance_km = params[:max_distance_km].presence&.to_f || DEFAULT_MAX_DISTANCE
  end

  def call
    filtered_customers = []

    File.foreach(@file_path).lazy.each do |line|
      customer = JSON.parse(line, symbolize_names: true)
      next unless valid_customer?(customer)

      distance = DistanceCalculator.new(
        @lat,
        @lon,
        customer[:latitude],
        customer[:longitude]
      ).call

      filtered_customers << customer if distance <= @max_distance_km
    rescue JSON::ParserError
      Rails.logger.warn "Skipping invalid JSON line: #{line.strip}"
      next
    end

    filtered_customers.sort_by { |c| c[:user_id] }
  end

  private

  def valid_customer?(customer)
    customer[:user_id] && customer[:name] && customer[:latitude] && customer[:longitude]
  end
end
