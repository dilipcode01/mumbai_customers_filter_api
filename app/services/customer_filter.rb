# app/services/customer_filter_service.rb
# frozen_string_literal: true

require 'json'

class CustomerFilter
  MUMBAI_COORDINATES = { lat: 19.0590317, lon: 72.7553452 }.freeze

  def initialize(file_path, max_distance_km = 100)
    @file_path = file_path
    @max_distance_km = max_distance_km
  end

  def call
    filtered_customers = []

    File.foreach(@file_path).lazy.each do |line|
      customer = JSON.parse(line, symbolize_names: true)
      next unless valid_customer?(customer)

      distance = DistanceCalculator.new(
        MUMBAI_COORDINATES[:lat],
        MUMBAI_COORDINATES[:lon],
        customer[:latitude],
        customer[:longitude]
      ).call

      filtered_customers << { user_id: customer[:user_id], name: customer[:name] } if distance <= @max_distance_km
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
