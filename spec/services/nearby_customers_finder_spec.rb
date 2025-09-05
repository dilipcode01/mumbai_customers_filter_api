# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NearbyCustomersFinder, type: :service do
  let(:file) { File.open(Rails.root.join('spec/fixtures/customers.txt')) }
  let(:lat) { 19.0590317 }
  let(:lon) { 72.7553452 }
  let(:max_distance_km) { 100 }

  subject(:result) do
    described_class.new(
      file: file,
      lat: lat,
      lon: lon,
      max_distance_km: max_distance_km
    ).call
  end

  it 'returns customers within 100 km of Mumbai' do
    expect(result).to include(
      a_hash_including(user_id: 25, name: 'Pratik'),
      a_hash_including(user_id: 32, name: 'Manish')
    )
  end

  it 'does not include customers outside 100 km' do
    expect(result).not_to include(
      a_hash_including(user_id: 3, name: 'Charlie')
    )
  end

  it 'skips invalid customer lines' do
    expect(result.map { |c| c[:user_id] }).not_to include(4)
  end

  it 'returns results sorted by user_id' do
    ids = result.map { |c| c[:user_id] }
    expect(ids).to eq(ids.sort)
  end

  context 'when lat, lon, or max_distance_km are missing' do
    subject(:default_result) do
      described_class.new(file: file).call
    end

    it 'uses default coordinates and max distance' do
      expect(default_result).to include(
        a_hash_including(user_id: 25, name: 'Pratik')
      )
      expect(default_result.map { |c| c[:user_id] }).to eq(default_result.map { |c| c[:user_id] }.sort)
    end
  end
end
